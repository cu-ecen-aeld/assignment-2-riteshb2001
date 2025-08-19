/*Setup syslog logging for your utility using the LOG_USER facility.

Use the syslog capability to write a message “Writing <string> to <file>” where <string> is the text string written to file (second argument) and <file> is the file created by the script.  This should be written with LOG_DEBUG level.

Use the syslog capability to log any unexpected errors with LOG_ERR level.*/
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <stdio.h>
#include <errno.h>
#include <string.h>
#include <syslog.h>

int main(int argc,char **argv)
{
int status;

    if (argc < 3) {

        openlog("writer",0,LOG_USER);
        syslog(LOG_ERR, "Insufficient arguments provided");
        closelog();
        return 1;
    }


openlog("writer",0,LOG_USER);

syslog(LOG_DEBUG, "Writing %s to %s", argv[2], argv[1]);

const char *filename = argv[1];

int fd = open(filename,
                O_RDWR|O_CREAT,
                S_IRWXU|S_IRWXG|S_IRWXO);

    if (fd < 0) {
        syslog(LOG_ERR, "Failed to open file: %s", filename);
        closelog();
        return 1;
    }

const char* buf = argv[2];


status = write(fd,buf,strlen(buf));

    if (status < 0) {
        syslog(LOG_ERR, "Failed to write to file: %s", filename);
        close(fd);
        closelog();
        return 1;
    }


closelog();
return 0;

}