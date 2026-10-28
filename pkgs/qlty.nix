{ lib, stdenvNoCC, fetchzip }:

stdenvNoCC.mkDerivation rec {
  pname = "qlty";
  version = "0.662.0";

  src = fetchzip {
    url = "https://github.com/qltysh/qlty/releases/download/v${version}/qlty-x86_64-unknown-linux-musl.tar.xz";
    hash = "sha256-vnEhGvSJA/joy67IvSHUEUrukGMsJHOihQg949A5J7U=";
  };

  installPhase = ''
    install -Dm755 qlty $out/bin/qlty
  '';

  meta = {
    description = "Code quality CLI: linting, formatting and code smells";
    homepage = "https://github.com/qltysh/qlty";
    license = lib.licenses.bsl11;
    platforms = [ "x86_64-linux" ];
    mainProgram = "qlty";
  };
}
