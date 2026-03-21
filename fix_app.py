with open('app.py', 'r') as f:
    content = f.read()

content = content.replace(
    'app.run(debug=True)\n\tapp.run(port=port, debug=debug)',
    'app.run(host="0.0.0.0", port=port, debug=debug)'
)

with open('app.py', 'w') as f:
    f.write(content)

print("Done!")
