#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#define Max 100

int main(){
	char flag[]="*", src[Max],dest[Max];
	int si=0,di=0;
	printf("Character Stuffing; \n");
	printf("Enter the the ASCII Data: \t");
	scanf("%s",src);
	strcpy(dest,flag);
	di++;
	while (src[si]!='\0'){
		if (src[si]=='*'){
			dest[di]='$';
			dest[di+1]='*';
			si++;
			di=di+2;
		}
		else if (src[si]=='$'){
			dest[di]='$';
			dest[di+1]='$';
			si++;
			di=di+2;
		}
		else
			dest[di++]=src[si++];
	}
	strcat(dest,flag);
	printf("The final Answer is: %s \n",dest);
}
