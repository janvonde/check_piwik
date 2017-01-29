# check_piwik

This is a monitoring plugin for [icinga](https://www.icinga.com) to check, if the [Piwik](jttps://piwik.org) version of the given URL is up to date.


### Requirements
Login to Piwik, go to your user settings and get your API authentication token there.


### Usage
Try the plugin at the command line like this:
```
./check_piwik.sh -u http://example.net/piwik/ -t MYTOKEN
```

You can define the icinga2 check command as follows:
```
/* Define check command for check_piwik */
object CheckCommand "piwik" {
  import "plugin-check-command"
  command = [ PluginDir + "/check_piwik.sh" ]

  arguments = {
    "-u" = {
      "required" = true
      "value" = "$pw_url$"
    }
    "-t" = {
      "required" = true
      "value" = "$pw_token$"
    }    
  }
}
```


### License
This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.
