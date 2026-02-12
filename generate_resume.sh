#!/bin/bash

# Script to generate PDF resume from HTML
# This script provides multiple methods to create the PDF

echo "======================================"
echo "  Resume PDF Generator"
echo "======================================"
echo ""

# Check if we're in the right directory
if [ ! -f "assets/resume.html" ]; then
    echo "❌ Error: resume.html not found in assets folder"
    echo "Please run this script from the portfolio root directory"
    exit 1
fi

echo "Choose a method to generate PDF:"
echo ""
echo "1. Using wkhtmltopdf (Recommended - Best Quality)"
echo "2. Open in browser for manual PDF save"
echo "3. Using headless Chrome (if available)"
echo ""
read -p "Enter your choice (1-3): " choice

case $choice in
    1)
        # Check if wkhtmltopdf is installed
        if command -v wkhtmltopdf &> /dev/null; then
            echo ""
            echo "📄 Generating PDF using wkhtmltopdf..."
            wkhtmltopdf --page-size A4 --margin-top 10mm --margin-bottom 10mm \
                        --margin-left 10mm --margin-right 10mm \
                        assets/resume.html assets/Vinay_Kumar_Resume.pdf
            
            if [ $? -eq 0 ]; then
                echo "✅ PDF generated successfully: assets/Vinay_Kumar_Resume.pdf"
            else
                echo "❌ Error generating PDF"
            fi
        else
            echo ""
            echo "❌ wkhtmltopdf is not installed"
            echo ""
            echo "To install:"
            echo "  Mac:     brew install wkhtmltopdf"
            echo "  Ubuntu:  sudo apt-get install wkhtmltopdf"
            echo "  Windows: Download from https://wkhtmltopdf.org/downloads.html"
        fi
        ;;
    
    2)
        echo ""
        echo "📂 Opening resume.html in your default browser..."
        echo ""
        echo "To save as PDF:"
        echo "  1. Press Cmd+P (Mac) or Ctrl+P (Windows/Linux)"
        echo "  2. Select 'Save as PDF'"
        echo "  3. Save as 'Vinay_Kumar_Resume.pdf' in the assets folder"
        echo ""
        
        # Open in default browser
        if [[ "$OSTYPE" == "darwin"* ]]; then
            open assets/resume.html
        elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
            xdg-open assets/resume.html
        else
            start assets/resume.html
        fi
        ;;
    
    3)
        # Check if Chrome is available
        if command -v google-chrome &> /dev/null || command -v chromium &> /dev/null; then
            echo ""
            echo "📄 Generating PDF using Chrome..."
            
            CHROME_PATH=""
            if command -v google-chrome &> /dev/null; then
                CHROME_PATH="google-chrome"
            elif command -v chromium &> /dev/null; then
                CHROME_PATH="chromium"
            elif [ -f "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" ]; then
                CHROME_PATH="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
            fi
            
            if [ ! -z "$CHROME_PATH" ]; then
                "$CHROME_PATH" --headless --disable-gpu --print-to-pdf=assets/Vinay_Kumar_Resume.pdf \
                               --print-to-pdf-no-header "file://$(pwd)/assets/resume.html"
                
                if [ $? -eq 0 ]; then
                    echo "✅ PDF generated successfully: assets/Vinay_Kumar_Resume.pdf"
                else
                    echo "❌ Error generating PDF"
                fi
            else
                echo "❌ Chrome not found"
            fi
        else
            echo ""
            echo "❌ Chrome/Chromium is not installed"
            echo "Please install Google Chrome or use another method"
        fi
        ;;
    
    *)
        echo ""
        echo "❌ Invalid choice. Please run the script again and choose 1, 2, or 3."
        exit 1
        ;;
esac

echo ""
echo "======================================"
echo "Done!"
echo "======================================"
