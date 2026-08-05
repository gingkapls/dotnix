{ config, ... } :

{
  programs = {
    niri = {
      enable = true;
      useNautilus = true;
    };

    gamescope = {
      enable = true;
      enableWsi = true;
      env = {
        # for Prime render offload on Nvidia laptops.
        # Also requires `hardware.nvidia.prime.offload.enable`.
        __NV_PRIME_RENDER_OFFLOAD = "1";
        __VK_LAYER_NV_optimus = "NVIDIA_only";
        __GLX_VENDOR_LIBRARY_NAME = "nvidia";
      };
    };
  };
}
