#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

void display(char *arr[]){
  for (int i=0;i<10;i++){
    printf("[%d]: %s\n",i, arr[i]);
  }
}

char *read(char *messages){
  int buffer = 256;
  int position = 0;

  char *cmd = malloc(sizeof(char) * buffer);
  char *character;

  int cha;
  int cont = 1;
  char firstchar;
  char lstchar;

  while (cont == 1){
    cha = fgetc(stdin);

    if (cha == EOF || cha == '\n')
      {
        cmd[position] = '\0';
        cont = 0;
      }
    else
      {
        cmd[position] = cha;
      }

    position++;

    if(position >= buffer){
      buffer += 256;
      cmd = realloc(cmd, buffer);
      if(cmd == NULL){
	return NULL;
      }
    }
  }
  
  if(isupper(cmd[0]) && (cmd[position-2] == '.' || cmd[position-2] == '?' || cmd[position-2] == '!')){
    return cmd;
  }else{
   printf("invalid message, keeping current \n");
   return messages;
  }
}

char *findnreplace(char *message) {
  char find_seq[100];
  char replace[100];
  char cha;
  int i = 0;

  printf("Please enter the character sequence to find: \n");
  cha = fgetc(stdin);

  while(cha != '\n' && i < sizeof(find_seq)-1){
    find_seq[i++] = cha;
    cha = fgetc(stdin);
  }
  find_seq[i] = '\0';

  i = 0;

  printf("Please enter the character sequence to replace: \n");
  cha = fgetc(stdin);

  while(cha != '\n' && i < sizeof(replace)-1){
  replace[i++] = cha;
  cha = fgetc(stdin);
  }
  replace[i] = '\0';

  char *post = message;

  while (*post != '\0'){

    int match = 1;
    for (int i=0; i< strlen(find_seq); i++){
      if(*(post + i) != find_seq[i]){
        match = 0;
        break;
      }
    }

    if(match){
      for(int i = 0; i < strlen(replace); i++)
      {
        *(post + i) = replace[i];
      }
        post += strlen(replace);

    }else{
      post++;
    }
  }
  printf("The new text is: %s\n", message);
  return message;
  }

	       
void freeUp(char *array[], int range) {   
  if(range < 10)
    {
      for(int i=0; i < range; i++){
	free(array[i]);
	array[i] = NULL;
      }
    } else {
      for(int i=0; i<10; i++){
	free(array[i]);
	array[i] = NULL;
      }
    }
  //  *array = NULL;
}
