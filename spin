#!/bin/sh

_copyright(){ echo "
  ozh lightweight shell extensions
  2008-2014 - anx @ ulzq de (Sebastian Glaser)
  Licensed under GNU GPL v3"; }
_license(){ echo "
  ozh is free software; you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation; either version 2, or (at your option)
  any later version.

  ozh is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this software; see the file COPYING.  If not, write to
  the Free Software Foundation, Inc., 59 Temple Place, Suite 330,
  Boston, MA 02111-1307 USA

  http://www.gnu.org/licenses/gpl.html"; }


_filter_spin(){
  busybox sed '/title.*\/title/!d;/SPIEGEL/d;s/<.title>//g;s/<title>//'; }

[ -n "OZH_REQUIRE" ] && {

  spin(){ spinlong | head -n1; }

  spinlong(){
    local url="http://www.spiegel.de/schlagzeilen/index.rss"
    wget -O- "$url" | _filter_spin; }; }

[ -n "FEED_REQUIRE" ] && {

  _feed_spin(){
    count=1; data="$(cat $task/cache | _filter_spin)"
    echo "$data" > $task/new
    [ "$(cat $task/new)" = "$(cat $task/cur)" ] || {
      echo "$data" > $task/cur
    DISPLAY=:0 notify-send -u critical "spin" "$data"; }; }

  _install_feed_spin(){
    local url="http://www.spiegel.de/schlagzeilen/index.rss"
    local p="$OZH/feed/list/spin"; mkdir -p "$p"; echo "$url" > "$p/url"; echo '. $OZH/feed/spin; _feed_spin' > "$p/onupdate"; }; }
