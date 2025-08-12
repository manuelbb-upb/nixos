{
  inputs = {
    t14g1.url = ./manuel-t14g1;
  };

  outputs = {self, t14g1, ...}:
  {
    nixosConfigurations = {
      "manuel-t14g1" = t14g1.nixosConfig-manuel-t14g1;
    };
  };
}
