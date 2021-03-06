{
  description = ''Wrapper for the C library wiringPi for controlling a Raspberry Pi's GPIO'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-wiringPiNim-master.flake = false;
  inputs.src-wiringPiNim-master.ref   = "refs/heads/master";
  inputs.src-wiringPiNim-master.owner = "ThomasTJdev";
  inputs.src-wiringPiNim-master.repo  = "nim_wiringPiNim";
  inputs.src-wiringPiNim-master.type  = "github";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-wiringPiNim-master"];
    over = if builtins.pathExists ./override.nix 
           then { override = import ./override.nix; }
           else { };
  in lib.mkRefOutput (over // {
    inherit self nixpkgs ;
    src  = deps."src-wiringPiNim-master";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  } );
}