{
  inputs = {
    t14g1.url = ./manuel-t14g1;
    p14sg5.url = ./manuel-p14sg5;
  };

  outputs = {self, t14g1, p14sg5, ...}:
  {
    nixosConfigurations = {
      "manuel-t14g1" = t14g1.nixosConfig-manuel-t14g1;
      "manuel-p14sg5" = p14sg5.nixosConfig-manuel-p14sg5;
    };
  };
}
