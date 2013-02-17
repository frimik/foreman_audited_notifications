# Ensure that module is namespaced with plugin name
module AuditedNotifications
  # Example: Create new instance and class methods on Foreman's Host model
  module AuditedExtensions
    extend ActiveSupport::Concern

    included do

      # ugh, use some functions from Foreman AuditsHelper.
      include ::AuditsHelper
      after_create :audit_notify

      private
      def audit_notify
        audit_subject = "#{self.username} #{audit_remote_address self} #{audit_action_name self} #{audited_type self} #{audit_title self}"
        audit_details = details(self)

        if SETTINGS[:audit_by_email][:enabled]
          AuditedNotifications::AuditMailer.audit_entry(audit_subject, audit_details).deliver
        end
        if SETTINGS[:audit_by_irc][:enabled]
          rbotnotify(audit_subject, audit_details)
        end

        nil
      end

      def rbotnotify(subject, details = [])
        password = SETTINGS[:audit_by_irc][:password] || "rbot"
        channel = SETTINGS[:audit_by_irc][:channel] || "#prod"
        address = SETTINGS[:audit_by_irc][:address] || "rbot"
        port = SETTINGS[:audit_by_irc][:port] || 7272
        message = "Foreman Audit: #{subject}\n" + details.join("\n")
        s = UDPSocket.new()
        logger.info("rbotnotify: sending #{subject} to #{channel}")
        bytes_sent = s.send("#{password}|#{channel}|#{message}", 0, address, port)
        logger.info("rbotnotify: #{bytes_sent} bytes sent")
        nil
      end

      # Helpers copied and modified from Foreman AuditsHelper
      def audit_remote_address audit
        return if audit.remote_address.empty?
        "(" + audit.remote_address + ")"
      end

      def details audit
        if audit.action == 'update'
          audit.audited_changes.map do |name, change|
            next if change.nil? or change.to_s.empty?
            if name == 'template'
              "Provisioning Template content changed. (Sorry, diff not supported.)" if audit_template? audit
            elsif name == "owner_id" || name == "owner_type"
              "Owner changed to #{audit.revision.owner rescue 'N/A'}"
            else
              "#{name.humanize} changed from #{id_to_label name, change[0]} to #{id_to_label name, change[1]}"
            end
          end
        elsif !main_object? audit
          ["#{audit_action_name(audit).humanize} #{id_to_label audit.audited_changes.keys[0], audit.audited_changes.values[0]}
           #{audit_action_name(audit)=="removed" ? "from" : "to"} #{id_to_label audit.audited_changes.keys[1], audit.audited_changes.values[1]}"]
        else
          []
        end
      end

      # included
    end

  end
end
