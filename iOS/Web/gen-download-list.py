
f = open('download-list', 'w')
for i in range(181):
    s = "http://devimages.apple.com/iphone/samples/bipbop/gear3/fileSequence" + str(i) + ".ts\n"
    f.write(s)
f.close()

