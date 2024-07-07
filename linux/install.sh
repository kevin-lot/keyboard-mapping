#!/usr/bin/env bash

set -o xtrace -o nounset -o pipefail

INSTALL_PATH=/usr/share/X11/xkb

# uninstall script
if [[ $1 == "uninstall" ]]; then
  for FILE in ${INSTALL_PATH}/rules/base.lst ${INSTALL_PATH}/rules/evdev.lst ${INSTALL_PATH}/rules/base.xml ${INSTALL_PATH}/rules/evdev.xml ${INSTALL_PATH}/symbols/fr; do
    if [ -f "${FILE}.iook.bck" ]; then
      mv "${FILE}.iook.bck" "${FILE}"
    fi
  done

  echo "Uninstall done."
  exit 0
fi

# install script
for FILE in ${INSTALL_PATH}/rules/base.lst ${INSTALL_PATH}/rules/evdev.lst ${INSTALL_PATH}/rules/base.xml ${INSTALL_PATH}/rules/evdev.xml ${INSTALL_PATH}/symbols/fr; do
  if [ ! -f "${FILE}.iook.bck" ]; then
    cp ${FILE} ${FILE}.iook.bck
    echo "$FILE saved."
  fi
done

for FILE in ${INSTALL_PATH}/rules/base.lst ${INSTALL_PATH}/rules/evdev.lst; do
  sed --in-place '/^! variant$/a \ \ iook            fr: French (iooK)' ${FILE}
done

XML_PATH="/xkbConfigRegistry/layoutList/layout/configItem/name[text()=\"fr\"]/../../variantList"
for FILE in ${INSTALL_PATH}/rules/base.xml ${INSTALL_PATH}/rules/evdev.xml; do
  xmlstarlet ed --inplace \
    --subnode "${XML_PATH}" --type elem -n "variant" \
    --subnode "${XML_PATH}/variant[last()]" --type elem -n "configItem" \
    --subnode "${XML_PATH}/variant[last()]/configItem" --type elem -n "name" -v "iook" \
    --subnode "${XML_PATH}/variant[last()]/configItem" --type elem -n "description" -v "French (iooK)" \
    ${FILE}
done

cat <<"EOF" >>${INSTALL_PATH}/symbols/fr

// ╔═════════════════╗
// ║           Shift ║
// ║ Shift     AltGr ║
// ║        ╬        ║
// ║                 ║
// ║ Sans      AltGr ║
// ╚═════════════════╝

// ┌─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┲━━━━━━━━━┓
// │ #   │ 1   │ 2   │ 3   │ 4   │ 5   │ 6   │ 7   │ 8   │ 9   │ 0   │     │ _   ┃    ⌫    ┃
// │ @   │ &   │ é ~ │ " ¨ │ ' ^ │ %   │ |   │ è ` │ ù   │ ç   │ à   │ °   │ -   ┃         ┃
// ┢━━━━━┷━┱───┴─┬───┴─┬───┴─┬───┴─┬───┴─┬───┴─┬───┴─┬───┴─┬───┴─┬───┴─┬───┴─┬───┺━┳━━━━━━━┫
// ┃ Tab   ┃ A   │ Z   │ E   │ R   │ T   │ Y   │ U   │ I   │ O Œ │ P ∏ │ \   │ * ¥ ┃       ┃
// ┃ ↹     ┃ a   │ z « │ e € │ r » │ t   │ y   │ u   │ i   │ o œ │ p π │ /   │ $ £ ┃   ⏎   ┃
// ┣━━━━━━━┻┱────┴┬────┴┬────┴┬────┴┬────┴┬────┴┬────┴┬────┴┬────┴┬────┴┬────┴┬────┺┓      ┃
// ┃ Maj    ┃ Q   │ S   │ D   │ F   │ G   │ H   │ J   │ K   │ L   │ M   │ {   │ }   ┃      ┃
// ┃ ⇬      ┃ q   │ s   │ d   │ f   │ g   │ h   │ j   │ k   │ l   │ m   │ ( [ │ ) ] ┃      ┃
// ┣━━━━━━━┳┹────┬┴────┬┴────┬┴────┬┴────┬┴────┬┴────┬┴────┬┴────┬┴────┬┴────┲┷━━━━━┻━━━━━━┫
// ┃ Shift ┃ > ≥ │ W   │ X   │ C   │ V   │ B   │ N   │ ?   │ .   │ !   │ + ± ┃    Shift    ┃
// ┃ ⇧     ┃ < ≤ │ w   │ x   │ c   │ v   │ b   │ n   │ ,   │ ;   │ :   │ = ≠ ┃    ⇧        ┃
// ┣━━━━━━━╋━━━━━┷━┳━━━┷━━━┱─┴─────┴─────┴─────┴─────┴─────┴───┲━┷━━━━━╈━━━━━┻━┳━━━━━━━┳━━━┛
// ┃ Ctrl  ┃       ┃       ┃ ␣         Espace fine insécable ⍽ ┃ AltGr ┃       ┃ Ctrl  ┃
// ┃       ┃       ┃       ┃ ␣ Espace       Espace insécable ⍽ ┃       ┃       ┃       ┃
// ┗━━━━━━━┻━━━━━━━┻━━━━━━━┹───────────────────────────────────┺━━━━━━━┻━━━━━━━┻━━━━━━━┛

partial alphanumeric_keys
xkb_symbols "iook" {

    name[Group1]= "French (iooK)";

    key <TLDE> { [ at,         numbersign                                 ] };

    key <AE01> { [ ampersand,  1,          dead_acute                     ] };
    key <AE02> { [ eacute,     2,          dead_tilde                     ] };
    key <AE03> { [ quotedbl,   3,          dead_diaeresis                 ] };
    key <AE04> { [ apostrophe, 4,          dead_circumflex                ] };
    key <AE05> { [ percent,    5                                          ] };
    key <AE06> { [ bar,        6                                          ] };
    key <AE07> { [ egrave,     7,          dead_grave                     ] };
    key <AE08> { [ ugrave,     8                                          ] };
    key <AE09> { [ ccedilla,   9                                          ] };
    key <AE10> { [ agrave,     0,          oslash,        Oslash          ] };
    key <AE11> { [ degree                                                 ] };
    key <AE12> { [ minus,      underscore, emdash,        endash          ] };

    key <BKSP> { [ BackSpace,  Delete                                     ] };

    key <AD01> { [ a,          A,          oa,            OA              ] };
    key <AD02> { [ z,          Z,          guillemotleft                  ] };
    key <AD03> { [ e,          E,          EuroSign                       ] };
    key <AD04> { [ r,          R,          guillemotright                 ] };
    key <AD05> { [ t,          T                                          ] };
    key <AD06> { [ y,          Y                                          ] };
    key <AD07> { [ u,          U                                          ] };
    key <AD08> { [ i,          I                                          ] };
    key <AD09> { [ o,          O,          oe,            OE              ] };
    key <AD10> { [ p,          P,          Greek_pi,      Greek_PI        ] };
    key <AD11> { [ slash,      backslash                                  ] };
    key <AD12> { [ dollar,     asterisk,   sterling,      yen             ] };

    key <CAPS> { [ Caps_Lock                                              ] };

    key <AC01> { [ q,          Q                                          ] };
    key <AC02> { [ s,          S                                          ] };
    key <AC03> { [ d,          D                                          ] };
    key <AC04> { [ f,          F                                          ] };
    key <AC05> { [ g,          G                                          ] };
    key <AC06> { [ h,          H                                          ] };
    key <AC07> { [ j,          J                                          ] };
    key <AC08> { [ k,          K                                          ] };
    key <AC09> { [ l,          L                                          ] };
    key <AC10> { [ m,          M                                          ] };
    key <AC11> { [ parenleft,  braceleft,  bracketleft                    ] };
    key <BKSL> { [ parenright, braceright, bracketright                   ] };

    key <LSGT> { [ less,       greater                                    ] };

    key <AB01> { [ w,          W                                          ] };
    key <AB02> { [ x,          X                                          ] };
    key <AB03> { [ c,          C                                          ] };
    key <AB04> { [ v,          V                                          ] };
    key <AB05> { [ b,          B                                          ] };
    key <AB06> { [ n,          N                                          ] };
    key <AB07> { [ comma,      question,   infinity,      questiondown    ] };
    key <AB08> { [ semicolon,  period,     ellipsis,      periodcentered  ] };
    key <AB09> { [ colon,      exclam,     division,      backslash       ] };
    key <AB10> { [ equal,      plus,       notequal,      plusminus       ] };

    key <SPCE> { [ space,      space,      nobreakspace                   ] };

    key <KPDL> { [ comma,      KP_Decimal                                 ] };

    include "level3(ralt_switch)"
};
EOF

echo "Install done."
