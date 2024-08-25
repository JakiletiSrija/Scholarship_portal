// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract AcadCerti {
    struct Certificate {
        string studentName;
        string certificateType;
        bytes32 certificateHash;
        string incomeCertificateImage;
        uint cg;
    }

    struct Donor {
        address donorAddress;
        uint256 donatedAmount; // Amount donated (in wei or other units)
        uint256 votingPower; // Proportional voting power based on donation
    }

    mapping(uint256 => Certificate) public certificates;
    mapping(address => Donor) public donors;
    uint256[] public studentIDs;

    // Store a certificate
    function storeCertificate(
        uint256 studentID,
        string memory name,
        string memory certType,
        bytes32 certHash,
        string memory incomeCertImage,
        uint cg
    ) external {
        certificates[studentID] = Certificate(name, certType, certHash, incomeCertImage,cg);
        studentIDs.push(studentID);
    }

    // Register a donor
    function registerDonor(address donor, uint256 donatedAmount) external {
        // Add donor registration logic (e.g., verify eligibility)
        donors[donor] = Donor(donor, donatedAmount, donatedAmount / 10); // 0.1 votes per wei donated
    }

    // Update voting power for a donor
    function updateVotingPower(address donor, uint256 newVotingPower) external {
        // Add logic to update voting power (e.g., based on donatedAmount)
        donors[donor].votingPower = newVotingPower;
    }

    // Get donor details
    function getDonor(address donor) external view returns (Donor memory) {
        return donors[donor];
    }

    struct Student {
        string name;
        uint256 votesReceived;
    }

    mapping(address => Student) public students;

    // Donor allocates votes to a student
    function allocateVotes(address studentAddress, uint256 votes) external {
        require(votes > 0, "Votes must be greater than zero");
        students[studentAddress].votesReceived += votes;
    }

    // Get the number of votes received by a student
    function getVotesReceived(address studentAddress) external view returns (uint256) {
        return students[studentAddress].votesReceived;
    }
} 