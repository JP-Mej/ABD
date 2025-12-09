document.addEventListener("DOMContentLoaded", function() {
    listarBeneficiarios();
});

function listarBeneficiarios() {
    fetch("http://localhost:8080/api/beneficiary/listar") // 🔹 nuevo endpoint
        .then(response => response.json())
        .then(data => {
            const tbody = document.getElementById("tablaBeneficiarios");
            tbody.innerHTML = "";
            if (!Array.isArray(data)) {
                console.error("La respuesta no es un array:", data);
                return;
            }
            data.forEach(b => {
                const row = document.createElement("tr");
                row.innerHTML = `
                    <td>${b.beneficiaryId}</td>
                    <td>${b.dniB}</td>
                    <td>${b.firstNameB}</td>
                    <td>${b.lastNameB}</td>
                    <td>${b.emailB}</td>
                    <td>${b.phoneB}</td>
                `;
                tbody.appendChild(row);
            });
        })
        .catch(err => console.error("Error listando beneficiarios:", err));
}

function guardarBeneficiario() {
    const b = {
        beneficiaryId: Number(document.getElementById("beneficiaryId").value),
        dniB: document.getElementById("dniB").value,
        institutionId: Number(document.getElementById("institutionId").value),
        gender: document.getElementById("gender").value,
        firstNameB: document.getElementById("firstNameB").value,
        lastNameB: document.getElementById("lastNameB").value,
        birthDateB: document.getElementById("birthDateB").value,
        occupation: document.getElementById("occupation").value,
        phoneB: document.getElementById("phoneB").value,
        emailB: document.getElementById("emailB").value
    };

    // Validar DNI antes de guardar
    fetch(`http://localhost:8080/api/beneficiary/dni/${b.dniB}`)
        .then(response => response.json())
        .then(existe => {
            if (existe) {
                alert("El DNI ya está registrado.");
            } else {
                fetch("http://localhost:8080/api/beneficiary/registrar", {
                    method: "POST",
                    headers: { "Content-Type": "application/json" },
                    body: JSON.stringify(b)
                })
                .then(res => res.text())
                .then(msg => {
                    alert(msg);
                    listarBeneficiarios(); // 🔹 refresca tabla
                })
                .catch(err => console.error("Error guardando beneficiario:", err));
            }
        });
}
