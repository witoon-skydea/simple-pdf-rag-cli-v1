#!/bin/bash

# สร้าง virtual environment
python3 -m venv venv

# เรียกใช้งาน virtual environment
source venv/bin/activate

# ติดตั้ง dependencies
pip install --upgrade pip
pip install -r requirements.txt --use-pep517

# ตรวจสอบว่า Ollama ถูกติดตั้งหรือไม่
if ! command -v ollama &> /dev/null; then
    echo "คำเตือน: ไม่พบคำสั่ง Ollama บนระบบ"
    echo "โปรดติดตั้ง Ollama จาก https://ollama.com/ ก่อนใช้งาน"
    echo ""
fi

# ตรวจสอบ Tesseract OCR
if ! command -v tesseract &> /dev/null; then
    echo "คำเตือน: ไม่พบคำสั่ง Tesseract OCR บนระบบ"
    echo "หากต้องการใช้ OCR กับ PDF ที่มีรูปภาพ โปรดติดตั้ง Tesseract OCR:"
    echo "- macOS: brew install tesseract"
    echo "- Ubuntu/Debian: sudo apt-get install tesseract-ocr"
    echo "- Windows: สามารถดาวน์โหลดได้จาก https://github.com/UB-Mannheim/tesseract/wiki"
    echo ""
    echo "สำหรับภาษาไทย หรือภาษาอื่นๆ เพิ่มเติม:"
    echo "- macOS: brew install tesseract-lang"
    echo "- Ubuntu/Debian: sudo apt-get install tesseract-ocr-tha"
    echo ""
fi

# แสดงข้อความแจ้งเตือนการใช้งาน
echo "การติดตั้งเสร็จสมบูรณ์!"
echo ""
echo "คำแนะนำในการใช้งาน:"
echo "1. เปิดใช้งาน virtual environment ทุกครั้งก่อนใช้โปรแกรม:"
echo "   source venv/bin/activate"
echo ""
echo "2. ตรวจสอบว่า Ollama กำลังทำงานอยู่:"
echo "   ollama serve"
echo ""
echo "3. ใช้คำสั่งนำเข้าข้อมูล (รองรับไฟล์ TXT, PDF, DOCX, CSV และ MD):"
echo "   python main.py ingest <path-to-file>"
echo ""
echo "4. การนำเข้าไฟล์ PDF ที่มีรูปภาพหรือต้องใช้ OCR:"
echo "   python main.py ingest <path-to-file> --ocr"
echo ""
echo "5. กำหนดภาษาสำหรับ OCR (ค่าเริ่มต้นคือ 'eng'):"
echo "   python main.py ingest <path-to-file> --ocr --ocr-lang 'tha+eng'"
echo ""
echo "6. เลือกเครื่องมือ OCR (tesseract หรือ easyocr):"
echo "   python main.py ingest <path-to-file> --ocr --ocr-engine easyocr"
echo ""
echo "7. ใช้คำสั่งถามคำถาม:"
echo "   python main.py query \"คำถามของคุณ\""
echo ""
echo "8. ใช้คำสั่งค้นหาแบบแสดงเฉพาะส่วนที่เกี่ยวข้อง (ไม่ผ่าน LLM):"
echo "   python main.py query \"คำถามของคุณ\" --raw-chunks"
echo ""
echo "9. ระบุจำนวนส่วนที่ต้องการค้นหา (ค่าเริ่มต้นคือ 4):"
echo "   python main.py query \"คำถามของคุณ\" --num-chunks 6"
echo ""
echo "10. เมื่อใช้งานเสร็จ ปิด virtual environment ด้วยคำสั่ง:"
echo "    deactivate"
