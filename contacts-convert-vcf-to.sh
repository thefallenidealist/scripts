#! /bin/sh
# https://vermaden.wordpress.com/2019/12/13/manage-contacts-the-unix-way/

# Copyright (c) 2018-2020 Slawomir Wojciech Wojtczak (vermaden)
# All rights reserved.
#
# THIS SOFTWARE USES FREEBSD LICENSE (ALSO KNOWN AS 2-CLAUSE BSD LICENSE)
# https://www.freebsd.org/copyright/freebsd-license.html
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that following conditions are met:
# 1. Redistributions of source code must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
# 2. Redistributions in binary form must reproduce the above copyright
#    notice, this list of conditions and the following disclaimer in the
#    documentation and/or other materials provided with the distribution.
#
# THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS 'AS IS' AND ANY
# EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
# WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE LIABLE FOR ANY
# DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
# (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
# LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
# ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
# THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
# ------------------------------
# CONTACTS CONVERT TO VCF FORMAT
# ------------------------------
# vermaden [AT] interia [DOT] pl
# https://vermaden.wordpress.com

__usage() {
  cat << __EOF
usage: ${0##*/} FILE

__EOF
  exit 1
}

if [ ${#} -ne 1 ]
then
  __usage
fi

if [ ! -e "${1}" ]
then
  echo "NOPE: file '${1}' does not exists"
  echo
  __usage
  exit 1
fi

vTELPREF=0

( cat "${1}"; echo ) \
  | grep -v '^NAME' \
  | grep -v '^#' \
  | sed -e s/$'\r'//g \
  | tr ',' ' ' \
  | while read vNAME vTELs vIMs vMAILs vNOTE
    do
      case "${vNAME}" in
        (====*) continue ;;
      esac

      if [ "${vNAME}" ]
      then
        echo "BEGIN:VCARD"
        echo "VERSION:2.1"
        echo "FN:${vNAME}" | tr '-' ' '

        # PHONE NUMBERS
        if [ "x${vTELs}" != "x-" ]
        then
          echo "${vTELs}" \
            | tr ';' '\n' \
            | while read vTEL
              do
                if [ ${vTELPREF} -ne 1 ]
                then
                  vTELPREF=1
                  echo "TEL;PREF:${vTEL}"
                else
                  echo "TEL:${vTEL}"
                fi
              done
        fi

        # INSTANT MESSAGING
        if [ "x${vIMs}" != "x-" ]
        then
          echo "${vIMs}" \
            | tr ';' '\n' \
            | while read vIM
              do
                echo "X-QQ:${vIM}"
              done
        fi

        # EMAILS
        if [ "x${vMAILs}" != "x-" ]
        then
          echo "${vMAILs}" \
            | tr ';' '\n' \
            | while read vMAIL
              do
                echo "EMAIL:${vMAIL}"
              done
        fi

        # NOTES
        if [ "x${vNOTE}" != "x-" ]
        then
          echo "NOTE:${vNOTE}"
        fi

        echo "END:VCARD"
      fi
    echo

    done

echo '1' >> ~/scripts/stats/${0##*/}
