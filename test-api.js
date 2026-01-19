const https = require('https');

// Test the Gemini API directly
const testGeminiAPI = async () => {
  const API_KEY = 'AIzaSyCpQzQSq4K0Vz0NAH1AxMFlXhtM_f2Yhvs';
  
  const models = [
    'models/gemini-1.5-flash-latest',
    'models/gemini-1.5-flash',
    'models/gemini-1.5-pro-latest',
    'models/gemini-1.5-pro',
    'models/gemini-pro'
  ];

  for (const model of models) {
    try {
      console.log(`Testing model: ${model}`);
      
      const data = JSON.stringify({
        contents: [{
          parts: [{
            text: "Say hello"
          }]
        }],
        generationConfig: {
          temperature: 0.7,
          maxOutputTokens: 100
        }
      });

      const options = {
        hostname: 'generativelanguage.googleapis.com',
        port: 443,
        path: `/v1beta/${model}:generateContent?key=${API_KEY}`,
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'Content-Length': data.length
        }
      };

      const response = await new Promise((resolve, reject) => {
        const req = https.request(options, (res) => {
          let responseBody = '';
          res.on('data', (chunk) => {
            responseBody += chunk;
          });
          res.on('end', () => {
            resolve({
              status: res.statusCode,
              body: responseBody
            });
          });
        });

        req.on('error', (error) => {
          reject(error);
        });

        req.write(data);
        req.end();
      });

      console.log(`Status: ${response.status}`);
      
      if (response.status === 200) {
        const responseData = JSON.parse(response.body);
        console.log('✅ Success!');
        console.log(JSON.stringify(responseData, null, 2));
        break;
      } else {
        console.log(`❌ Error: ${response.body}`);
      }
      
    } catch (error) {
      console.log(`❌ Network error: ${error.message}`);
    }
    
    console.log('---');
  }
};

testGeminiAPI();