#include <stdio.h>
#include <unistd.h>
#include <string.h>

/**
* Game Ai
* Helper stript app for running development functions
* returns -1 on error, 0 on help, and 1 after succesful program execution
**/

int main(int argc, char *argv[]) {
    printf("Running with game.ai helper script\n");

    // Set program name to use
    char *programName = "poetry";
 
    // break if invalid args count
    if(argc != 2) {
        printf("incorrect number of args (%d)\n", argc);
        return -1;
    }
    // save args to variable.
    char const *arg = argv[1];
    // comandline arguments 
    char *args[] = {programName, "run", NULL, NULL, NULL, NULL, NULL, NULL};
    char *path;

    if (strcmp(arg,"--build-api")==0 || strcmp(arg,"-ba")==0) {
        // Set args to build the pyx files in the Game api library 
        printf("building cython files for api library");
        path = "plugins/SerpentZeroADGamePlugin/files/api";
        args[2] = "cythonize";
        args[3] = "-a";
        args[4] = "-i";
        args[5] = "*.pyx";
    } else if (strcmp(arg,"--build-ml")==0 || strcmp(arg,"-bm")==0) {
        // set args to build the pyx files in the GameAgent helpers library
        printf("building cython files for machine learning library");
        path = "plugins/SerpentOzymandiasGameAgent/files/ml_models";
        args[2] = "cythonize";
        args[3] = "-a";
        args[4] = "-i";
        args[5] = "*.pyx";
    } else if (strcmp(arg,"--build-helpers")==0 || strcmp(arg,"-bh")==0) {
        // set args to build the pyx files in the GameAgent helpers library
        printf("building cython files for helpers library");
        path = "plugins/SerpentOzymandiasGameAgent/files/helpers";
        args[2] = "cythonize";
        args[3] = "-a";
        args[4] = "-i";
        args[5] = "*.pyx";
    } else if(strcmp(arg,"--launch-game")==0 || strcmp(arg,"-l")==0) {
        // set args to launch Zero.AD game with serpent
        printf("launching game with serpent.ai");
        path = "./";
        args[2] = "serpent";
        args[3] = "launch";
        args[4] = "ZeroAD";
    } else if (strcmp(arg,"--play-game")==0 || strcmp(arg,"-p")==0) {
        // set args to play Zero.AD game, with the game agent 
        printf("playing game with serpent.ai");
        path = "./";
        args[2] = "serpent";
        args[3] = "play";
        args[4] = "ZeroAD";
        args[5] = "SerpentOzymandiasGameAgent";
    } else if (strcmp(arg,"--capture-frame")==0 || strcmp(arg,"-c")==0) { 
        // set args to capture game frames of Zero.AD game 
        printf("capturing frames with serpent.ai");
        path = "./";
        args[2] = "serpent";
        args[3] = "capture";
        args[4] = "frame";
        args[5] = "ZeroAD";
        args[6] = "1";
    } else if (strcmp(arg, "-h") == 0) {
        // get the help args and return
        printf("showing poetry help");
        char *exec_arg = "--help";
        execlp(programName, programName, exec_arg, NULL);
        return 0;
    } else {
        // catch an invalid arg and print help and return.
        printf("Invalid Arguments\n");
        char *exec_arg = "--help";
        execlp(programName, programName, exec_arg, NULL);
        return -1;
    }
    // change directory to required dir
    chdir(path);
    printf("\n");
    // execute commands
    execvp(programName, args);
    printf("\n");
    return 1;
}
