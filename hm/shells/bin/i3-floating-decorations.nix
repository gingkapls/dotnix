{ pkgs }:

pkgs.writers.writePython3Bin "i3-floating-decorations" { libraries = [ pkgs.python39Packages.i3ipc ]; } ''
    import i3ipc
    
    i3 = i3ipc.Connection()
    

    def border_on_floating(i3, e):

        if (e.container.floating == 'user_off'):
            e.container.command('border pixel 4')
            e.container.command('title_format "%title"')
        elif (e.container.floating == 'user_on'):
            e.container.command('border normal 0')
            e.container.command('title_format "<b></b>"')


    i3.on('window::floating', border_on_floating)

    i3.main()
''
