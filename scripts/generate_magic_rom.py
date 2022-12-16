ADDR_WIDTH = 8
DATA_WIDTH = 32

f = open(f"./rtl/generated/magic_rom_{ADDR_WIDTH}x{DATA_WIDTH}.mem","w")

def prng(n):
    """Simple pseudorandom number generator using a linear congruential generator.
    Output doesn't really look random which is a bit sad but it works for our 
    purposes (not having periodicity, large numbers of repeats or a simple pattern,
    each of which would make it possible for bugs to go undetected when using as
    testing data.)"""
    a = 16433347.971242
    m = 256
    c = 74
    return int((a*n + c) % m )

text = "\n".join(["".join(f"{prng(row*DATA_WIDTH+column):02X}" for column in range(DATA_WIDTH//8))  for row in range(2**ADDR_WIDTH)])

f.write(text)

f.close()