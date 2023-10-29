<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Loading Page</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
                margin: 0;
                background-color: #333;
            }

            #loading-container {
                text-align: center;
            }

            #loading-spinner {
                width: 100px;
                height: 100px;
                border: 5px solid transparent;
                border-top: 5px solid #4CAF50;
                border-radius: 50%;
                animation: spin 2s linear infinite;
                display: inline-block;
                transition: border 0.3s, border-top 0.3s, transform 0.3s;
            }

            #loading-text {
                font-size: 24px;
                color: #4CAF50;
                margin-top: 20px;
                transition: color 0.3s;
            }

            @keyframes spin {
                0% {
                    transform: rotate(0deg);
                }
                100% {
                    transform: rotate(360deg);
                }
            }
        </style>
    </head>
    <body>
        <div id="loading-container">
            <div id="loading-spinner"></div>
            <div id="loading-text">Loading...</div>
        </div>

        <script>
        const indication = <%= request.getAttribute("indication") %>;
        const message = "<%= request.getAttribute("Message") %>";
        const redirectURL = "<%= request.getAttribute("redirectURL") %>";

        setTimeout(function () {
            const loadingText = document.getElementById('loading-text');
            const loadingSpinner = document.getElementById('loading-spinner');

            if (indication) {
                loadingText.innerText = message;
                loadingText.style.color = '#4CAF50';
                loadingSpinner.style.border = '5px solid #4CAF50';
                loadingSpinner.style.borderTop = '5px solid transparent';
            } else {
                loadingText.innerText = message;
                loadingText.style.color = 'red';
                loadingSpinner.style.border = '5px solid red';
                loadingSpinner.style.borderTop = '5px solid red';
            }
        }, 2000);

        setTimeout(function () {
            window.location.href = redirectURL;
        }, 4000);
        </script>
    </body>
</html>
