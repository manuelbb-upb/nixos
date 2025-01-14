{lib
, stdenvNoCC
, fetchzip
}:
stdenvNoCC.mkDerivation rec {
  pname = "segoe-ui";
  version = "0.1";

  # src = fetchFromGitHub {
  #   owner = "mrbvrz";
  #   repo = "segoe-ui-linux";
  #   #rev = "a89213b7136da6dd5c3638db1f2c6e814c40fa84";
  #   rev = "99e186ba96970877312d827ca43e1f9db10de370";
  #   hash = "sha256-0IFpJiRHJNA+1jtbvdiAJYLQZrCw8yv5Mlk+Efla1aE=";
  #   sparseCheckout = [
  #     "font/"
  #   ];
  # };
  src = fetchzip {
    url = "https://github.com/mrbvrz/segoe-ui-linux/archive/refs/heads/master.zip";
    hash = "sha256-0KXfNu/J1/OUnj0jeQDnYgTdeAIHcV+M+vCPie6AZcU=";
  };


  buildPhase = ''
    mkdir -p $out/share/fonts/truetype
    cp ./font/*.ttf $out/share/fonts/truetype
  '';

  dontInstall = true;
  dontFixup = true;

  meta = with lib; {
    description = "Segoe UI";
  };
}
