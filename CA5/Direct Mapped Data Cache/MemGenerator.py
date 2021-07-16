
def ShitGenerator(n_word, start, end):
    f = open("datamemory.txt", "w")
    z = 0
    for i in range(n_word):
        if i < start or i > end:
            tmp = "{:032b}".format(0)
        else:
            tmp = "{:032b}".format(z)
            z += 1
        f.write(str(tmp) + '\n')
    f.close()

if __name__ == '__main__':
    ShitGenerator(32000, 1000, 9000)