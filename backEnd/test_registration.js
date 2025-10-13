import fetch from 'node-fetch';

async function testRegistration() {
    try {
        console.log('Testing registration with invalid data...');
        
        const response = await fetch('http://localhost:3300/users/registration', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({
                name: '',
                password: '123',
                email: 'invalid-email',
                telSzam: '123456'
            })
        });
        
        const result = await response.text();
        console.log('Status:', response.status);
        console.log('Response:', result);
        
    } catch (error) {
        console.error('Error:', error.message);
    }
}

testRegistration();