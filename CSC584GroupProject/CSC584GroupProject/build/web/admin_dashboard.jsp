<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.election.model.UserBean"%> 

<%
    // 2. Security Check: Retrieve the UserBean
    UserBean currentUser = (UserBean) session.getAttribute("currentUser");

    // 3. Validation: Check if user is logged in AND is actually an Admin
    if (currentUser == null || !currentUser.getRole().equalsIgnoreCase("admin")) {
        // If not logged in or not an admin, force them back to login
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <style>
        /* Exact CSS from your admin_dashboard.html */
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); min-height: 100vh; padding: 20px; }
        header { text-align: center; padding: 40px 20px; animation: fadeInDown 0.8s ease-out; }
        header h1 { color: white; font-size: 2.5rem; font-weight: 700; text-shadow: 2px 2px 4px rgba(0,0,0,0.2); margin-bottom: 15px; }
        header p { color: white; font-size: 1.1rem; opacity: 0.95; }
        header p strong { font-weight: 600; }
        main { max-width: 1200px; margin: 0 auto; animation: fadeInUp 0.8s ease-out; }
        section { background: white; border-radius: 20px; padding: 40px; box-shadow: 0 20px 60px rgba(0,0,0,0.3); margin-bottom: 30px; }
        h2 { color: #333; margin-bottom: 30px; font-size: 1.8rem; position: relative; padding-bottom: 15px; }
        h2::after { content: ''; position: absolute; bottom: 0; left: 0; width: 60px; height: 4px; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); border-radius: 2px; }
        .stats-card { display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 20px; margin-bottom: 30px; }
        .stat-item { background: linear-gradient(135deg, rgba(102, 126, 234, 0.1) 0%, rgba(118, 75, 162, 0.1) 100%); padding: 25px; border-radius: 12px; text-align: center; border: 2px solid rgba(102, 126, 234, 0.2); }
        .stat-number { font-size: 2.5rem; font-weight: 700; color: #667eea; margin-bottom: 8px; }
        .stat-label { color: #555; font-size: 0.95rem; font-weight: 500; }
        .candidates-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); gap: 25px; margin-top: 30px; }
        .candidate-card { background: #fafafa; border-radius: 15px; overflow: hidden; box-shadow: 0 4px 15px rgba(0,0,0,0.1); transition: all 0.3s ease; border: 2px solid #e0e0e0; }
        .candidate-card:hover { transform: translateY(-5px); box-shadow: 0 8px 25px rgba(102, 126, 234, 0.3); border-color: #667eea; }
        .candidate-image { width: 100%; height: 250px; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); display: flex; align-items: center; justify-content: center; font-size: 5rem; color: white; position: relative; }
        .candidate-image img { width: 50%; height: 100%; object-fit: cover; object-position: center; display: block; }
        .candidate-info { padding: 25px; }
        .candidate-name { font-size: 1.3rem; font-weight: 700; color: #333; margin-bottom: 10px; }
        .slogan-text { font-size: 0.95rem; color: #666; line-height: 1.6; }
        nav { text-align: center; margin-top: 20px; animation: fadeIn 1s ease-out 0.5s both; }
        nav a { display: inline-block; padding: 12px 30px; background: white; color: #667eea; text-decoration: none; border-radius: 10px; font-weight: 600; transition: all 0.3s ease; box-shadow: 0 4px 15px rgba(0,0,0,0.2); }
        nav a:hover { transform: translateY(-2px); box-shadow: 0 6px 20px rgba(0,0,0,0.3); background: #f8f9fa; }
        
        @keyframes fadeInDown { from { opacity: 0; transform: translateY(-30px); } to { opacity: 1; transform: translateY(0); } }
        @keyframes fadeInUp { from { opacity: 0; transform: translateY(30px); } to { opacity: 1; transform: translateY(0); } }
        @keyframes fadeIn { from { opacity: 0; } to { opacity: 1; } }
    </style>
</head>
<body>
    <header>
        <h1>Admin Control Panel</h1>
        <p>Welcome, <strong><%= currentUser.getName() %></strong>. Manage candidates and view real-time results.</p>
    </header>
    
    <main>
        <section>
            <h2>Current Voting Results</h2>
            
            <div class="stats-card">
                <div class="stat-item">
                    <div class="stat-number">100</div>
                    <div class="stat-label">Total Votes Cast</div>
                </div>
                <div class="stat-item">
                    <div class="stat-number">3</div>
                    <div class="stat-label">Active Candidates</div>
                </div>
                <div class="stat-item">
                    <div class="stat-number">45%</div>
                    <div class="stat-label">Leading Percentage</div>
                </div>
            </div>

            <div class="candidates-grid">
                <div class="candidate-card">
                    <div class="candidate-image">
                        <img src="picture/formalpic_1.jpg" alt="Candidate 1">
                    </div>
                    <div class="candidate-info">
                        <div class="candidate-name">Candidate A - John Smith</div>
                        <div class="slogan-section">
                            <div class="slogan-text">"Excellence Through Innovation"</div>
                        </div>
                    </div>
                </div>

                <div class="candidate-card">
                    <div class="candidate-image">
                        <img src="picture/formalpic_3.jpg" alt="Candidate 2">
                    </div>
                    <div class="candidate-info">
                        <div class="candidate-name">Candidate B - Emily Chen</div>
                        <div class="slogan-section">
                            <div class="slogan-text">"Sustainability, Inclusion, Support"</div>
                        </div>
                    </div>
                </div>

                <div class="candidate-card">
                    <div class="candidate-image">
                        <img src="picture/photo.jpg" alt="Candidate 3">
                    </div>
                    <div class="candidate-info">
                        <div class="candidate-name">Candidate C - Marcus Lee</div>
                        <div class="slogan-section">
                            <div class="slogan-text">"Together We Rise"</div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <section>
            <h2>Manage Candidates</h2>
            
            <div style="margin-bottom: 20px; text-align: right;">
                <a href="addCandidate.jsp" style="display: inline-block; padding: 12px 25px; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; text-decoration: none; border-radius: 10px; font-weight: 600; box-shadow: 0 4px 15px rgba(102, 126, 234, 0.4); transition: all 0.3s ease;">
                    ➕ Add New Candidate
                </a>
            </div>

            <table style="width: 100%; border-collapse: separate; border-spacing: 0; overflow: hidden; border-radius: 12px; box-shadow: 0 4px 15px rgba(0,0,0,0.1);">
                <thead style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);">
                    <tr>
                        <th style="color: white; padding: 18px; text-align: left; font-weight: 600;">No.</th>
                        <th style="color: white; padding: 18px; text-align: left; font-weight: 600;">Candidate Name</th>
                        <th style="color: white; padding: 18px; text-align: left; font-weight: 600;">ID</th>
                        <th style="color: white; padding: 18px; text-align: left; font-weight: 600;">Slogan</th>
                        <th style="color: white; padding: 18px; text-align: center; font-weight: 600;">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <tr style="background: #fafafa;">
                        <td style="padding: 18px; color: #333; border-bottom: 1px solid #e0e0e0;">1</td>
                        <td style="padding: 18px; color: #333; border-bottom: 1px solid #e0e0e0;">Candidate A - John Smith</td>
                        <td style="padding: 18px; color: #667eea; border-bottom: 1px solid #e0e0e0; font-weight: 500;">A001</td>
                        <td style="padding: 18px; color: #333; border-bottom: 1px solid #e0e0e0; font-style: italic;">"Excellence Through Innovation"</td>
                        <td style="padding: 18px; border-bottom: 1px solid #e0e0e0; text-align: center;">
                            <button style="padding: 8px 16px; background: #4facfe; color: white; border: none; border-radius: 6px; cursor: pointer; margin-right: 5px; font-weight: 600;">Edit</button>
                            <button style="padding: 8px 16px; background: #dc3545; color: white; border: none; border-radius: 6px; cursor: pointer; font-weight: 600;">Delete</button>
                        </td>
                    </tr>
                    </tbody>
            </table>
        </section>
    </main>
    
    <nav>
        <a href="LogoutServlet">Logout</a>
    </nav>
</body>
</html>