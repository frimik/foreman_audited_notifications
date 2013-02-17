module AuditedNotifications
  class AuditMailer < ActionMailer::Base

    def audit_entry(audit_subject, audit_details)
      @audit = audit_subject
      @audit_details = audit_details
      email = SETTINGS[:audit_by_email][:recipients] || Setting[:administrator]
      raise "unable to find recipients" if email.empty?
      recipients = email
      sender_address = Setting["email_reply_address"]
      subject "[Foreman Audit] #{audit_subject}"
      mail(:to => recipients,
           :from => sender_address,
           :subject => subject) do |format|
             format.html
             format.text
           end
    end


  end
end
