{ config }:

{
  enable = true;
  settings = {
    delay = 15;

    color_scheme = 0;
    tree_view = 0;

    fields = with config.lib.htop.fields; [
      PID
      USER
      PRIORITY
      NICE
      M_SIZE
      M_RESIDENT
      M_SHARE
      STATE
      PERCENT_CPU
      PERCENT_MEM
      TIME
      COMM
    ];

    highlight_base_name = 0;
    highlight_megabytes = 1;
    highlight_threads = 1;

    show_thread_names = 0;
    show_program_path = 1;

    hide_threads = 0;
    hide_kernel_threads = 1;
    hide_userland_threads = 0;

    sort_key = 47;
    sort_direction = 1;

  } // (with config.lib.htop; leftMeters [
    (bar "LeftCPUs")
    (bar "Memory")
    (bar "Swap")
    (text "Zram")
    (text "Systemd")
  ]) // (with config.lib.htop; rightMeters [
    (bar "RightCPUs")
    (text "Tasks")
    (text "LoadAverage")
    (text "Uptime")
    (text "Battery")
  ]);
}
