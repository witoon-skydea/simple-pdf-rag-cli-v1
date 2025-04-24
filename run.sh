#!/bin/bash

# ตรวจสอบว่ามี virtual environment หรือไม่
if [ ! -d "venv" ]; then
    echo "ไม่พบ virtual environment กำลังเรียกใช้ setup.sh..."
    ./setup.sh
    if [ $? -ne 0 ]; then
        echo "ไม่สามารถติดตั้งได้ กรุณาเรียกใช้ setup.sh ด้วยตนเอง"
        exit 1
    fi
fi

# เรียกใช้งาน virtual environment
source venv/bin/activate

# ตรวจสอบว่า Ollama กำลังทำงานอยู่หรือไม่
if ! curl -s -o /dev/null -w "%{http_code}" http://localhost:11434/api/tags | grep -q "200"; then
    echo "คำเตือน: ไม่พบ Ollama กำลังทำงานอยู่"
    echo "กรุณาเริ่มการทำงานของ Ollama ด้วยคำสั่ง: ollama serve"
    
    # ถามผู้ใช้ว่าต้องการดำเนินการต่อหรือไม่
    read -p "ต้องการดำเนินการต่อหรือไม่? (y/n): " continue_response
    if [[ ! $continue_response =~ ^[Yy]$ ]]; then
        deactivate
        exit 1
    fi
fi

# ตรวจสอบว่าโมเดลที่ต้องการมีอยู่หรือไม่
if ! curl -s http://localhost:11434/api/tags | grep -q "llama3:8b"; then
    echo "ไม่พบโมเดล llama3:8b กำลังดาวน์โหลด..."
    ollama pull llama3:8b
fi

if ! curl -s http://localhost:11434/api/tags | grep -q "mxbai-embed-large"; then
    echo "ไม่พบโมเดล mxbai-embed-large กำลังดาวน์โหลด..."
    ollama pull mxbai-embed-large
fi

# เรียกใช้ main.py ด้วย arguments ที่ได้รับ
python main.py "$@"

# เก็บค่า exit code
exit_code=$?

# แสดงข้อความช่วยเหลือหากไม่มี arguments
if [ $# -eq 0 ]; then
    echo ""
    echo "วิธีใช้งาน: ./run.sh [ingest|query] [options]"
    echo ""
    echo "คำสั่ง:"
    echo "  ingest    - นำเข้าเอกสาร"
    echo "  query     - ค้นหาและตอบคำถาม"
    echo ""
    echo "ตัวอย่าง:"
    echo "  ./run.sh ingest data/document.pdf"
    echo "  ./run.sh ingest data/document.pdf --ocr"
    echo "  ./run.sh ingest data/document.pdf --ocr --ocr-lang 'tha+eng'"
    echo "  ./run.sh query \"คำถามของคุณ\""
    echo ""
    echo "ใช้ './run.sh ingest --help' หรือ './run.sh query --help' สำหรับตัวเลือกเพิ่มเติม"
fi

# ปิด virtual environment
deactivate

exit $exit_code
