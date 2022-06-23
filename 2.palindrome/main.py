from string import ascii_letters

def checkPalindrome(word: str, ignore_punc_case: bool = True) -> bool:
    # if necessary, ignore all characters except lower case alphabet
    if ignore_punc_case:
        word = [w.lower() for w in word if w in ascii_letters]

    # arguable edge case with len = 0
    if len(word) < 2: 
        return True

    # get midpoint rounded down
    halfway = len(word) // 2

    # check char by char until halfway is reached or mismatch is found
    for i, j in enumerate(word):
        if j != word[-(i + 1)]:
            return False

        if i > halfway:
            return True


if __name__ == '__main__':
    myWord = 'Ma is as selfless as I am.'
    print('myWord:', checkPalindrome(myWord))

    mySuperLongPalindrome = '''
    Dennis, Nell, Edna, Leon, Nedra, Anita, Rolf, Nora, Alice, Carol, Leo, Jane, 
    Reed, Dena, Dale, Basil, Rae, Penny, Lana, Dave, Denny, Lena, Ida, Bernadette, 
    Ben, Ray, Lila, Nina, Jo, Ira, Mara, Sara, Mario, Jan, Ina, Lily, Arne, Bette, 
    Dan, Reba, Diane, Lynn, Ed, Eva, Dana, Lynne, Pearl, Isabel, Ada, Ned, Dee, 
    Rena, Joel, Lora, Cecil, Aaron, Flora, Tina, Arden, Noel, and Ellen sinned.'''
    
    print('mySuperLongPalindrome:', checkPalindrome(mySuperLongPalindrome))