// User data structure
struct User {
    username: string,
    walletAddress: Address,
    joinedChallenges: Vec<u32>,
    // Add more user-related information as needed
}

// Storage variable for all users
let mut users: StorageMap<Address, User> = StorageMap {};

// Event for user registration
event UserRegistered(string, Address);

// Function to register a new user
fun registerUser(username: string, walletAddress: Address) {
    users.insert(walletAddress, User {
        username,
        walletAddress,
        joinedChallenges: Vec::new(),
    });

    emit UserRegistered(username, walletAddress);
}

// Function to track joined challenges
fun addJoinedChallenge(challengeId: u32) {
    users.get_mut(context.caller)?.joinedChallenges.push(challengeId);
}

// Other functions for managing user data (e.g., update username)
