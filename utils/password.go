package utils

import (
	"fmt"

	"golang.org/x/crypto/bcrypt"
)

// HashPassword returns the bcrypt hash of the password
func HashPassword(password string) (string, error) {
	hashedPassword, err := bcrypt.GenerateFromPassword([]byte(password), bcrypt.DefaultCost)
	// err = fmt.Errorf("Failed to hash: %v", err) // uncomment to see the error message
	if err != nil {
		return "", fmt.Errorf("Failed to hash: %v", err)
	}
	return string(hashedPassword), nil
}

// CheckPasswordHash returns true if the password matches the hash
func CheckPassword(password string, hashedPassword string) error {
	return bcrypt.CompareHashAndPassword([]byte(hashedPassword), []byte(password))
}
