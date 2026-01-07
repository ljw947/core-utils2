#include <stdbool.h>  // TODO: make own
#include <errno.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>

bool FORCE = false;
bool INTERACTIVE = false;
bool VERBOSE = false;

int processArgs(int argc, char* argv[])
{
    // keep track of where relevant args start from
    // to ignore cases like "arg1 --flag arg2" which are unhandled (for now)
    int relevantArgsIndex = 1;

    // skip program name
    for (int i = 1; i < argc; ++i)
    {
        if (strcmp(argv[i], "--force") == 0 || strcmp(argv[i], "-f") == 0)
        {
            FORCE = true;
            relevantArgsIndex = i + 1;
            break;
        }

        if (strcmp(argv[i], "-v") == 0 || strcmp(argv[i], "--verbose") == 0)
        {
            VERBOSE = true;
            relevantArgsIndex = i + 1;
            break;
        }

        if (strcmp(argv[i], "-i") == 0)
        {
            INTERACTIVE = true;
            relevantArgsIndex = i + 1;
            break;
        }
    }

    if (VERBOSE)
        printf("Num args: %d\nRelevant args index: %d\n", argc, relevantArgsIndex);

    return relevantArgsIndex;
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
        if (VERBOSE)
            printf("Attempting removal: %s\n", argv[i]);

        int ret = unlink(argv[i]);

        if (FORCE)
        {
            break;
        }
        else if (ret != 0)
        {
            printf("%s: cannot remove '%s': %s\n", argv[0], argv[i], strerror(errno));
            return ret;
        }
    }

    return 0;
}
