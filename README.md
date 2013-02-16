Foreman Audited Notifications
=============================

A simple (but ugly) plugin that sends Audit events via email and lately also
to IRC via [Rbot](http://ruby-rbot.org/).

# Installation:

Add to Gemfile as:

    gem 'audited_notifications', :git => 'https://github.com/frimik/foreman_audited_notifications.git', :branch => 'irc'

# Usage:


Add to your Foreman `config/settings.yaml`:

```yaml
:audit_by_irc: true
:audit_by_irc:
  :address: rbot-server.example.com
  :port: 7272
  :channel: "#theforeman"
  :password: rbot
:audit_by_email: true
:audit_by_email:
  :recipients:
    - bossman@example.com
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
