module AuditedNotifications
  require 'audited_notifications/engine' if defined?(Rails) && Rails::VERSION::MAJOR == 3
  require 'socket'
end
