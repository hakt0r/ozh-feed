#!/bin/sh

_copyright(){ echo "
  ozh lightweight shell extensions
  2008-2016 - anx @ ulzq de (Sebastian Glaser)
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


_filter_spin(){ busybox sed -n '/<title/{s/<title>//;s/<\/title>//;p}'| iconv -f iso-8859-1 -t utf-8 | Btail -n +3; }

[ -n "OZH_REQUIRE" ] && {
  _feed_spin_defaults(){ url="http://www.spiegel.de/schlagzeilen/index.rss"; }
  spin(){ spinlong | head -n1; }
  spinlong(){ _feed_spin_defaults; wget -qO- "$url" | _filter_spin | _format_title; }; }

[ -n "FEED_REQUIRE" ] && {
  _feed_spin(){ count=1; format=_filter_spin; }; }
