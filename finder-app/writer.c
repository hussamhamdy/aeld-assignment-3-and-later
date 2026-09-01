#include <stdio.h>
#include <stdlib.h>
#include <syslog.h>

int main (int argc  ,char * argv[])
{
    FILE *file; 
    openlog("writer" , LOG_PID , LOG_USER);
    if(argc != 3)
    {
        syslog(LOG_ERR , "Invalid number of arguments");
        fprintf(stderr ,"Usage: %s <writefile> <writestr>\n", argv[0]);
        closelog();
        return 1;
    }
    const char *writefile = argv[1];
    const char *writestr =  argv[2];

    file = fopen(writefile ,"w");
    if(file == NULL)
    {
        syslog(LOG_ERR, "Could not open file %s for writing", writefile);
        fprintf(stderr, "Error: could not open file %s\n", writefile);
        closelog();
        return 1;
    }

    syslog(LOG_DEBUG, "Writing %s to %s", writestr, writefile);


    if (fprintf(file, "%s", writestr) < 0)
    {
        syslog(LOG_ERR, "Failed writing to file %s", writefile);
        fprintf(stderr, "Error: failed writing to file %s\n", writefile);
        fclose(file);
        closelog();
        return 1;
    }

    if (fclose(file) != 0)
    {
        syslog(LOG_ERR, "Failed to close file %s", writefile);
        fprintf(stderr, "Error: failed to close file %s\n", writefile);
        closelog();
        return 1;
    }
    closelog();
    return 0;
}