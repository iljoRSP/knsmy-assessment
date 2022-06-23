public class PalindromeGenius {
    private static boolean checkPalindrome(String word, boolean ignore_punc_case) {        
        // if necessary, ignore all characters except lower case alphabet
        if (ignore_punc_case)
            word = word.replaceAll("(\\s+)|([\\p{P}\\p{S}])", "").toLowerCase();

        int len = word.length();

        // arguable edge case with len = 0
        if (len < 2) 
            return true;

        // get midpoint rounded down
        int halfway = len / 2;

        // check char by char until halfway is reached or mismatch is found
        for (int i = 0; i < halfway; i++) {
            if (word.charAt(i) != word.charAt(len - i - 1))
                return false;
        }
        return true;
    }

    // overload for default ignore_punc_case
    private static boolean checkPalindrome(String word) {
        return checkPalindrome(word, true);
    }
    

    public static void main(String[] args) {
        String myWord = "Ma is as selfless as I am.";
        System.out.println("myWord: " + checkPalindrome(myWord)); 
    
        String mySuperLongPalindrome = "Dennis, Nell, Edna, Leon, Nedra, Anita, Rolf, Nora, Alice, Carol, Leo, Jane, Reed, Dena, Dale, Basil, Rae, Penny, Lana, Dave, Denny, Lena, Ida, Bernadette, Ben, Ray, Lila, Nina, Jo, Ira, Mara, Sara, Mario, Jan, Ina, Lily, Arne, Bette, Dan, Reba, Diane, Lynn, Ed, Eva, Dana, Lynne, Pearl, Isabel, Ada, Ned, Dee, Rena, Joel, Lora, Cecil, Aaron, Flora, Tina, Arden, Noel, and Ellen sinned.";
        System.out.println("mySuperLongPalindrome: " + checkPalindrome(mySuperLongPalindrome)); 
    }
}