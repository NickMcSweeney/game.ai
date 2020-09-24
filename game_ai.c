#include <stdio.h>
#include <unistd.h>
#include <string.h>

int main(int argc, char *argv[]) {
    printf("Running with game.ai helper script\n");

    char *programName = "bash";
    char *poetry = "poetry";
 
    char const *arg = argv[1];

    if (strcmp(arg,"--build-api")==0 || strcmp(arg,"-ba")==0) {
        printf("building cython files for api library");
        char *build_api = "(cd plugins/SerpentZeroADGamePlugin/files/api && poetry run cythonize -a -i *.pyx)";
        execlp(programName, programName, build_api, NULL);
    } else if (strcmp(arg,"--build-helpers")==0 || strcmp(arg,"-bh")==0) {
        printf("building cython files for helpers library");
        char *build_helpers = "(cd plugins/SerpentOzymandiasGameAgent/files/helpers && poetry run cythonize -a -i *.pyx)";
        execlp(programName, programName, build_helpers, NULL);
    } else if(strcmp(arg,"--launch-game")==0 || strcmp(arg,"-l")==0) {
        printf("launching game with serpent.ai");
        //execlp(programName, programName, "poetry run serpent launch ZeroAD", NULL);
        char *launch[] = {poetry, "run", "serpent","launch","ZeroAD",NULL};
        execvp(poetry, launch);
    } else if (strcmp(arg,"--play-game")==0 || strcmp(arg,"-p")==0) {
        printf("playing game with serpent.ai");
        char *launch[] = {
            poetry,
            "run",
            "serpent",
            "play",
            "ZeroAD",
            "SerpentOzymandiasGameAgent",
            NULL
        };
        execvp(poetry, launch);
    } else if (strcmp(arg, "-h") == 0) {
        printf("showing poetry help");
        char *exec_arg = "--help";
        execlp(poetry, poetry, exec_arg, NULL);
    } else {
        printf("Invalid Arguments");
    }
    printf("\n");
    return 0;
}
