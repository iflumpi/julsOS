
ASSEMBLER=nasm
SRC_FOLDER=src/asm
SRC_BOOT=$(SRC_FOLDER)/bootloader/boot.asm
TARGET_FOLDER=build
TARGET=$(TARGET_FOLDER)/boot.bin

$(TARGET): 
	mkdir -p $(TARGET_FOLDER)
	$(ASSEMBLER) $(SRC_BOOT) -i $(SRC_FOLDER) -f bin -o $(TARGET)  

clean:
	rm -Rf $(TARGET_FOLDER)

