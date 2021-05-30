import Foundation

// 139. word break
/*
 Given a string s and a dictionary of strings wordDict, return true if s can be segmented into a space-separated sequence of one or more dictionary words.

 Note that the same word in the dictionary may be reused multiple times in the segmentation.
 
 Solution:
 Brute force solution - will be going through each of the element in wordDict and checking if the element is present in the prefix of the given string.
- as the prefix == element, drop the prefix part and pass the remaining part as a s (recurssively)
- until s is empty. As s is empty, return true
 */

// using Brute force
public func wordBreakBF(_ s: String, _ wordDict: [String]) -> Bool {
    if s.count == 0 {
        return true
    }
    
    for dString in wordDict { // O(W)
        let prefix = String(s.prefix(dString.count)) // O(k), k - count of dString
        if prefix == dString && wordBreakBF(String(s.dropFirst(dString.count)), wordDict){
            return true // O(k), k - count of dString
        }
    }
    return false
}

// time complexity : O(W * 2n), W - size of the dictionaryArray, n - size of s
// space complexity : O(s)

/* Now, lets use DP
 using top-down approach, memoization
 Requirement for memoization - for a given string return true or false
 */

public func wordBreakDP(_ s: String, _ wordDict: [String]) -> Bool {
    var dp = [String: Bool]()
    let ans =  wordBreak(s, wordDict, &dp)
    
    print(dp)
    return ans
}

func wordBreak(_ s: String, _ wordDict: [String], _ dp: inout [String: Bool]) -> Bool {
    if s.count == 0 {
        return true
    } else if dp[s] != nil {
        return dp[s]!
    }
    
    for dString in wordDict {
        let prefix = String(s.prefix(dString.count))
        if prefix == dString && wordBreak(String(s.dropFirst(dString.count)), wordDict, &dp) {
            dp[s] = true
            return true
        }
    }
    dp[s] = false
    return false
}

// now, the time complexity - O(W * n2) -- polynomial
// space complexity: O(n)
