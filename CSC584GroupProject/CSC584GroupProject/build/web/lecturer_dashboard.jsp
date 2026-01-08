<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // Security Check
    String role = (String) session.getAttribute("role");
    if(role == null || !role.equals("lecturer")) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Lecturer Dashboard</title>
    <style>
        /* ... (Paste your exact CSS from lecturer_dashboard.html here) ... */
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); min-height: 100vh; padding: 20px; }
        header { text-align: center; padding: 40px 20px; animation: fadeInDown 0.8s ease-out; }
        header h1 { color: white; font-size: 2.5rem; font-weight: 700; text-shadow: 2px 2px 4px rgba(0,0,0,0.2); margin-bottom: 15px; }
        header p { color: white; font-size: 1.1rem; opacity: 0.95; }
        main { max-width: 1200px; margin: 0 auto; animation: fadeInUp 0.8s ease-out; }
        section { background: white; border-radius: 20px; padding: 40px; box-shadow: 0 20px 60px rgba(0,0,0,0.3); margin-bottom: 30px; }
        h2 { color: #333; margin-bottom: 30px; font-size: 1.8rem; position: relative; padding-bottom: 15px; }
        h2::after { content: ''; position: absolute; bottom: 0; left: 0; width: 60px; height: 4px; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); border-radius: 2px; }
        /* Add table styles and other CSS here from your file */
        .student-table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        .student-table th, .student-table td { padding: 12px; border: 1px solid #ddd; text-align: left; }
        .vote-status.voted { color: green; font-weight: bold; }
        .vote-status.not-voted { color: red; font-weight: bold; }
        .student-list-container { display: none; }
        .student-list-container.active { display: block; animation: fadeIn 0.5s; }
        
        @keyframes fadeInDown { from { opacity: 0; transform: translateY(-30px); } to { opacity: 1; transform: translateY(0); } }
        @keyframes fadeInUp { from { opacity: 0; transform: translateY(30px); } to { opacity: 1; transform: translateY(0); } }
        @keyframes fadeIn { from { opacity: 0; } to { opacity: 1; } }
    </style>
</head>
<body>
    <header>
        <h1>Lecturer Dashboard</h1>
        <p>Welcome, <strong>Lecturer</strong>. View real-time voting results.</p>
    </header>
    
    <main>
        <section>
            <h2>Current Voting Results</h2>
            </section>

        <section>
            <h2>Student Voting Status by Faculty</h2>
            
            <div class="faculty-section">
                <div class="faculty-selector">
                    <label for="faculty-dropdown">Select Faculty:</label>
                    <select id="faculty-dropdown" onchange="showFacultyStudents(this.value)">
                        <option value="">-- Choose a Faculty --</option>
                        <option value="fskm">Faculty of Computer Science and Mathematics (FSKM)</option>
                        <option value="engineering">Faculty of Engineering</option>
                        <option value="business">Faculty of Business and Management</option>
                    </select>
                </div>

                <div id="no-selection" class="no-faculty">
                    Please select a faculty to view student voting status
                </div>

                <div id="fskm-students" class="student-list-container">
                    <table class="student-table">
                        <thead>
                            <tr>
                                <th>No.</th>
                                <th>Student Name</th>
                                <th>Student ID</th>
                                <th>Voting Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr class="voted-row">
                                <td>1</td>
                                <td>Ali Imran bin Ahmad</td>
                                <td class="student-id">FSKM001</td>
                                <td><span class="vote-status voted">✓ Voted</span></td>
                            </tr>
                        </tbody>
                    </table>
                </div>

                <div id="engineering-students" class="student-list-container">
                    </div>
            </div>
        </section>
    </main>
    
    <nav>
        <a href="LogoutServlet">Logout</a>
    </nav>

    <script>
        function showFacultyStudents(faculty) {
            document.querySelectorAll('.student-list-container').forEach(list => {
                list.classList.remove('active');
            });
            document.getElementById('no-selection').style.display = 'none';
            if (faculty === '') {
                document.getElementById('no-selection').style.display = 'block';
            } else {
                const selectedList = document.getElementById(faculty + '-students');
                if (selectedList) {
                    selectedList.classList.add('active');
                }
            }
        }
    </script>
</body>
</html>