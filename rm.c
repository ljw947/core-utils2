#include <stdbool.h>  // TODO: make own
#include <errno.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>

bool FORCE = false;
bool INTERACTIVE = false;

int processArgs(int argc, char* argv[])
{
    // keep track of where relevant args start from
    // to ignore cases like "arg1 --flag arg2" which are unhandled (for now)
    int relevantArgs = 1;

    // skip program name
    for (int i = 1; i < argc; ++i)
    {
        if (strcmp(argv[i], "-f"))
        {
            FORCE = true;
            ++relevantArgs;
            break;
        }

        if (strcmp(argv[i], "--force"))
        {
            FORCE = true;
            ++relevantArgs;
            break;
        }
    }

    return relevantArgs;
}

int main(int argc, char* argv[])
{
    if (argc < 2)
    {
        printf("%s: missing operand\n", argv[0]);
        return 1;
    }

    int relevantArgs = processArgs(argc, argv);

    // don't remove rm itself
    for (int i = relevantArgs; i < argc; ++i)
    {
        int ret = unlink(argv[i]);
        if (ret != 0 && FORCE)
        {
            printf("%s: cannot remove '%s': %s\n", argv[0], argv[i], strerror(errno));
            return ret;
        }
    }

    return 0;
}
