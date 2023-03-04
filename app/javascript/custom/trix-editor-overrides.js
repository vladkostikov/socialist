window.addEventListener("trix-file-accept", function(event) {
    const acceptedTypes = ['image/jpeg', 'image/png']
    if (!acceptedTypes.includes(event.file.type)) {
        event.preventDefault()
        alert("Можно загружать только файлы PNG и JPEG")
    }

    const maxFileSize = 1024 * 1024 // 1MB
    if (event.file.size > maxFileSize) {
        event.preventDefault()
        alert("Файл должен быть не больше 1 мегабайта")
    }
})
