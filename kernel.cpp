void printf(char* str){
    
    static unsigned short* VideoMemory = (unsigned short*)0xb8000;
    
    for(int i = 0; str[i]!='\0'; i++){
        VideoMemory[i] = (VideoMemory[i] & 0xFF00) | str[i];
    }
    
}

typedef void (*constructor)();

extern "C" constructor start_ctors;
extern "C" constructor end_ctors;

extern "C" void callConstructors(void* multiboot_structure, unsigned int /*multiboot_magic*/){

    for(constructor* i = &start_ctors; i != &end_ctors; i++){
        (*i)();        
    }
    
}

extern "C" void ankaMain(){

    printf("AnkaTeam...");
    
    while(1);
    
}
