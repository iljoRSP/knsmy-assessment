def findMissing(arr: list) -> int:
    length = len(arr) + 1  # plus 1 because 0-based index

    if length < 2:
        return "ERROR: bad input.\n\tArray too small."
    
    try:
        return length * (length + 1) // 2 - sum(arr)
    except Exception as e:
        return "ERROR: bad input.\n\t" + str(e)


if __name__ == '__main__':
    size = 210
    intendedMissing = 66
    
    myArr = [i for i in range(1, size) if i != intendedMissing]
    print('Missing number:', findMissing(myArr))