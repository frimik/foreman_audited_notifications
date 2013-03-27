Foreman Audited Notifications
=============================

A simple (but ugly) plugin that sends Audit events via email and lately also
to IRC via [Rbot](http://ruby-rbot.org/).

# Installation:

Add to Gemfile as:

    gem 'audited_notifications', :git => 'https://github.com/frimik/foreman_audited_notifications.git'

# Usage:


Add to your Foreman `config/settings.yaml`:

```yaml
:audit_by_irc:
  :enabled: true
  :address: rbot-server.example.com
  :port: 7272
  :channel: "#theforeman"
  :password: rbot
:audit_by_email:
  :enabled: true
  :recipients:
    - bossman@example.com
```

# Example output:

This is a newly created host that took 7 minutes to build sent to some IRC
channel:

```
19:11 < rbot> Foreman Audit: Weird Al (10.0.2.123) created Host centos6-1.mg8.example.com
19:18 < rbot> Foreman Audit: Admin User (10.50.0.183) updated Host centos6-1.mg8.example.com
19:18 < rbot> Build changed from true to false
19:18 < rbot> Installed at changed from N/A to 2013-03-27 18:18:07 UTC
19:18 < rbot> Foreman Audit: Admin User (10.0.10.10) updated Host centos6-1.mg8.example.com
19:18 < rbot> Certname changed from N/A to centos6-1.mg8.example.com
```

The IRC notifications require a special UDP listener program that sits between
your rbot and TheForeman. See `extras/rbot-proxy.rb`

# Copyright

Copyright (c) 2012-2013 Mikael Fridh except where otherwise noted.

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
