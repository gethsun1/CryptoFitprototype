// Challenge data structure
struct Challenge {
    name: string,
    challengeType: string, // Add challenge type
    exerciseDetails: string, // Add exercise details
    startTime: u64,
    endTime: u64,
    entryFee: Coin,
    winner: Option<Address>,
    totalEntries: u32,
}

// Storage variable for all challenges
let mut challenges: StorageMap<u32, Challenge> = StorageMap {};

// Event for challenge creation
event ChallengeCreated(u32, string, string, u64, u64, Coin);

// Function to create a new challenge
fun createChallenge(name: string, challengeType: string, exerciseDetails: string, startTime: u64, endTime: u64, entryFee: Coin) {
    assert!(endTime > startTime);
    let challengeId = challenges.len() as u32;
    challenges.insert(challengeId, Challenge {
        name,
        challengeType,
        exerciseDetails,
        startTime,
        endTime,
        entryFee,
        winner: Option::none(),
        totalEntries: 0,
    });

    emit ChallengeCreated(challengeId, name, challengeType, startTime, endTime, entryFee);
}

// Function to join a challenge
fun joinChallenge(challengeId: u32) payable {
    assert!(entryFee >= challenges.get(challengeId)?.entryFee);
    assert!(now() < challenges.get(challengeId)?.endTime);
    challenges.get_mut(challengeId)?.totalEntries += 1;
    // Send entry fee to winner or contract (depending on logic)
}

// Function to declare a winner (called after challenge ends)
fun declareWinner(challengeId: u32, winner: Address) {
    assert!(now() > challenges.get(challengeId)?.endTime);
    challenges.get_mut(challengeId)?.winner = Option::some(winner);
    // Transfer accumulated funds to winner
}

// Other functions for managing challenges (e.g., cancel challenge, update details)

