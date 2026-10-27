{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "agent-deck";
  version = "1.16.34";

  src = fetchFromGitHub {
    owner = "asheshgoplani";
    repo = "agent-deck";
    rev = "v${version}";
    hash = "sha256-fehA9JNE/viQ4hAZ0djyignluQWRoYunKnQOWRLv+YA=";
  };

  vendorHash = "sha256-MPtWVgxZ6JKrLOtujlueHAisyRXf7w6lBW+CPRLg3kE=";

  # TODO: drop once nixpkgs Go reaches 1.26.10 (upstream's go.mod minimum).
  postPatch = ''
    substituteInPlace go.mod --replace-fail "go 1.26.10" "go 1.26.8"
  '';

  env = {
    CGO_ENABLED = 0;
    GOTOOLCHAIN = "local";
  };

  subPackages = [ "cmd/agent-deck" ];

  ldflags = [
    "-s"
    "-w"
    "-X main.Version=${version}"
  ];

  doCheck = false;

  meta = {
    description = "Terminal session manager for AI coding agents";
    homepage = "https://github.com/asheshgoplani/agent-deck";
    license = lib.licenses.mit;
    mainProgram = "agent-deck";
  };
}
