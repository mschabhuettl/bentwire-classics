#!/usr/bin/env bash
# Source list of the classics pack: prints the absolute path of every character source, one
# per line, in the order the pack is built. `--palette` prints the Office palette source
# (MSO97.DLL, Office 97), `--theme` the balloon theme source (OBALLOON.DLL 10.0.2607,
# Office XP, German).
#
#   BENTWIRE_SOURCES=<dir>[:<dir>...] ./sources.sh [--palette | --theme]
#
# BENTWIRE_SOURCES: one or more directories with your own copies of the original files, in
# any layout. Each file below is found by its file name (exact case: it becomes the id and
# `source.file` of the character) anywhere under these directories and verified by SHA-256.
# All Microsoft-specific file names of this pack live here.
set -euo pipefail
if [ -z "${BENTWIRE_SOURCES:-}" ]; then
  echo "NOT RUN: set BENTWIRE_SOURCES" >&2
  exit 77
fi
want=char
case "${1:-}" in
  --palette) want=palette ;;
  --theme) want=theme ;;
  "") ;;
  *) echo "usage: sources.sh [--palette | --theme]" >&2; exit 2 ;;
esac

# kind  SHA-256  file name
list() {
  cat <<'EOF'
# Agent 2.0 (ACS)
char 0ed1ab3ee8f349d0c2b5446029049be1d64c2294b2b72343ddd5e69e62e08e5f CLIPPIT.ACS
char 278359f2e866e43142f2bc6205544e97a241292d57ff7cebd63376358a0c0902 DOT.ACS
char a27cac0b65264634c20b48dab2e8342d37d5351493620dd073e54969c611d800 F1.ACS
char 9abeab7b8b62599b6afdd13d44d79b5566ceb523711c092e72eb185fb419426c LOGO.ACS
char 7f305422bc0721b275a2b88fb0679d8e363fe7b0c55ffde8bbe9aa439df44db8 MNATURE.ACS
char ee578e00ee2ed8f64f0efbafd83cc80a9ac715ce5c1f08db52d5f693f8288322 OFFCAT.ACS
char 952ba4531bf748dacdc7314e7b934889fb06a01687f00f7b0e10850112788eea ROCKY.ACS
char daa0c43f23a91674f62600c64acfd4c29636c86db4248ab01644e3d04664d92d courtney.acs
char 7698d85971d3b19ed424b841624d87a740d2cd7062becf1e71d96c16c2999a90 earl.acs
char 87887195179efe07ad6ee7a44fafbc0fa6b96d0990ec604f5651951c647f8f9e genie.acs
char a88151f313bea60002c5e5cb8b4d7dc5e2d919ba8fe78db1a4d05279a9ad58d7 merlin.acs
char b8112187525051bfade06cb678390d52c79555c960202cc5bbf5901fbc0853c5 peedy.acs
char 08a13b0f04e97da4a6d8be0ddbec1e6f1b1244398109cfe3fcd518eb7332d163 qmark.acs
char b8b1d44cecfd53bb7f9e8f483ab2dab0274314fda0c389214451305dbad9efa5 robby.acs
char 1b2cd6df82cf583d6d8817c19f5154b221d33b00650d41359a917080b64327d2 rover.acs
# Agent 1.5 (OLE ACS)
char c7e8e80dd8fab1f2315f7b4b60dca12e081e35eb5dcc0b97f659819cfccc21a8 merlin.acs
char 437ccc7943cbc8d9364f07387c4a55c5e27b24a5ca604878c2dddb07da301cf9 Al.acs
char 069f6a62765e43fff3bfb7092f16023544f69d571b5b2f45f2377e5946687d6e Check.acs
char f19dae253ad71cc64e6d152e0439f6c30945f3de5b0699ed47a9d873d0ea219c Gourdy.acs
char 72b9189584b3c4925de510a3cdece910cad7eab413724517162a3be66257097a Max.acs
char 3d792565767898d085323aced25cce9a37d9327fa28de2ab47720e679e11e0fc Miku.acs
char c6d1eafb646af38408cf06dcb505cd0d262bc096f4b6059ecb609135c6668245 Ozzar.acs
char 3119ae86024fb7a7c660121723ad3f23f27fdde5c70e1a139aee293eb7308260 Sharky.acs
char 490a5b57bf4139206525bbe7643af87ba9888bcdd7e429a234af606ec32bc580 Spaceman.acs
char ea2970bdb80a86e552ec9c67b08c5282ce41d43d5cbde8a26857adae1159cc40 Totem.acs
# Office 97 and Microsoft Bob actors (ACT)
char 08a36be2f88dab26bb6b20d78e114f38fab0ce2777b3c136128a81bc59e0f9cb BAUD.ACT
char e881d4d1c7ae1113a85cb018788012e8e63294f4e7d8c996b359cf3686508a82 BLYTHE.ACT
char 8836f8bbb7f36cee9e8ce1bba24b653e8efddbb1d0f06515c2cd3d87705a0d2b CHAOS.ACT
char 91814700d2d619ceda221e6a101f99439b01a27cbaf477e263efa7c6da14d0c7 CHAZ.ACT
char 47026de14f910ac2c51e6e509a043ac8e43fd24e0de8266e8feeeadbf65cac4b CLIPPIT.ACT
char 3c0594c1fcd2b74ffd5f5d50cdec1b7271fcf6a63e46423916d84cad2b3c1a15 DOLPHIN.act
char 4f647cecee8ebccd000429b825612f2436e2f42000661427b80c5cd8b281fa47 DOT(Bob).ACT
char d9e450149b2c6ea37be33da70d165aff624f2721239b3c605a073585c465f15c DOT(Office).act
char f3109a7e78f7c3af68b3320b8aced3c58daaaa5465af2779b9e83919baebf19c EARL.act
char fff92968d040d0f1b5567624bf6faa0eeb09e2e11d48ea801e3b9c73d5e8ae4f GENIUS.act
char 254fc752165496eeeadf3555333aeb94e4892026aad40bcdaa963e11430a109c HANK.ACT
char 66d23ef84e1dc6e26044b53e6e7c40961ed26f565d1504c26e2e92c44cab858c HOPPER.ACT
char 4f8916e24e5213d092c5c845f0056d31d7a0cc112f326ef7f2e6c28d9595ff24 HOVERBOT.act
char 291dbe23f6f3f1af01c0658546d60423125bc2351a0c82edb6f8e5548ab72974 JAVA.ACT
char 3d1343b3e82c6b93ca8f005e9d1df09fa0ffafda9834750453a06b51ef7fa4a6 LEXX.ACT
char 37b09750ba6163b167aa273227902b2f6c27a721ca367a77d01620cfa79d8a4e LOGO.act
char fd5e70e4d4549de23aa47eb4b5c411e2dd430501c3d0dbe9507cb48b11df7ae2 LUCY.ACT
char 131b407d77e5116b5a72155a80aa3b7a53779a5871beb3e2d65a8ef5271bb2db MNATURE.act
char ab97f06cc0c42bfcdca09dae9f5b80c27654ad8e4928217b9fbb523ec6dcf3c8 OFFLADY.act
char 8bf1eebb778d67d22e0b500630075126f3920f0c4cdbde4d85292df06be9b46e ORBY.ACT
char 26701407f7599c3e0c600a138fadc8551a0de33bc76d42c53cef7f5aca74030d POWERPUP.act
char fcb2001c7746d17e8cbf1424edf2a03fbf890641f447637b37f92868cd1caf9b ROBOT.act
char c94ed42b47bb4c2106113eecd8001d72088fe3725580cd2ef67be526c0eadc66 ROCKY(EarlyGreetings).ACT
char 02376b7ac73be74fcfb3265ae9d8193ed732918b14c915c984cc00f42ff8cc53 ROCKY(Greetings).ACT
char 8757ff434aa9d5fab6f60e6690f621b408c3c5d749b3fac7ef1e7a398a883c35 ROCKY(Office).act
char ef4f9b9d2c69d87b8f8cb42b6af53f8516d211670a5e027d5c778ce439c31520 ROVER.ACT
char b207d1878da00f033a43f53f557c05261aa7b2eefc26f99512ea0b310195a309 RUBY.ACT
char d1d3e47ef76eeaac8c481b0a8fac89410a851908cbfc4b9f7719ac888c378b44 SCRIBBLE.act
char 4e6d88c1f5d5659b1150a78373e948eb933bb1b11d0ed5eea0278b151ca0741e SCUZZ.ACT
char 9a66defb85d254c1def41f2eb34116f013d26be5a697fcb643ad93287ecb573d SHELLY.ACT
char e7040d39c4b9963ee380e4ca232377df71513d5fd606403d9f34d229591a4838 TOFFLOGO.act
char b216ece9a23a02497fb07381effa9652ebcefb316391580374fd4d18f60e9909 TUTOR.ACT
char bfcc81933a17a314fe68d5d624a2a4290034807b3a40a93b805814bfc257743d WILL(Bob).ACT
char 00e7169818797384dd1bfc67773396bcf5559eab93c5af27072fae56a94af22d WILL(Office).act
char 6a187196b1064276147632c30183f68a373da5e5307ec2bd78bcd2cd34ad6901 WORM.ACT
char 16205230b9f7d069cf371990aeac2b4e358415aae224658d81b7c9246377909b ZSPEAKER.ACT
# Office palette and balloon theme
palette 4d382905037551ef6b830a28b5b70b55043332c064665da30bae32095da1722d MSO97.DLL
theme 686dfb1a491d73454691cbb5a1e272bb24348aa07c5647aa23ee26e985608f96 OBALLOON.DLL
EOF
}

IFS=: read -r -a dirs <<< "$BENTWIRE_SOURCES"
for d in "${dirs[@]}"; do
  if [ ! -d "$d" ]; then
    echo "NOT RUN: $d (in BENTWIRE_SOURCES) is not a directory" >&2
    exit 77
  fi
done
# Every file under the directories once, as "name<TAB>absolute path".
index=$(for d in "${dirs[@]}"; do
  find "$(cd "$d" && pwd -P)/" -type f -printf '%f\t%p\n'
done)

while read -r kind sha name; do
  case "$kind" in '' | '#'*) continue ;; esac
  [ "$kind" = "$want" ] || continue
  found=
  while IFS= read -r p; do
    if [ "$(sha256sum < "$p" | cut -c1-64)" = "$sha" ]; then
      found=$p
      break
    fi
  done < <(awk -F'\t' -v n="$name" '$1 == n { print $2 }' <<< "$index")
  if [ -z "$found" ]; then
    echo "NOT RUN: $name (SHA-256 $sha) not found under BENTWIRE_SOURCES" >&2
    exit 77
  fi
  printf '%s\n' "$found"
done < <(list)
