
{ lib, rustPlatform, fetchFromGitHub, ... }:

rustPlatform.buildRustPackage rec {
  pname = "tiktok_cli_adaptor";
  version = "0.1.0";

  src = ./.;

  # cargoLock = {
  #   lockFile = ./Cargo.lock;
  # };

  meta = with lib; {
    description = "A CLI adaptor for TikTok";
    homepage = "https://github.com/meta-introspector/streamofrandom";
    license = licenses.mit;
    maintainers = [ ];
  };
}
