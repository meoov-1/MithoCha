<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MithoCha Admin — Analytics</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <script src="https://unpkg.com/@phosphor-icons/web"></script>
    <style>
        :root {
            --bg-color:      #FCF8F5;
            --card-bg:       #FFFFFF;
            --text-main:     #2A2421;
            --text-muted:    #807771;
            --brand-brown:   #76533B;
            --accent-orange: #DE8543;
            --accent-green:  #27A667;
            --border-color:  #F1EAE4;
            --active-bg:     #FDF1E6;
        }
        *, *::before, *::after { margin:0; padding:0; box-sizing:border-box; font-family:'Inter',sans-serif; }
        body { background-color:var(--bg-color); color:var(--text-main); }

        /* Layout */
        .dashboard { display:flex; height:100vh; overflow:hidden; }

        /* Sidebar */
        .sidebar {
            width:260px; min-width:260px; background-color:var(--bg-color);
            display:flex; flex-direction:column; border-right:1px solid var(--border-color);
        }
        .sidebar-header { padding:30px 24px 20px; }
        .sidebar-header h2 { font-size:20px; font-weight:700; margin-bottom:4px; }
        .sidebar-header p  { font-size:12px; color:var(--text-muted); }
        .sidebar-nav { flex:1; display:flex; flex-direction:column; gap:4px; padding:0 16px; }
        .nav-item {
            display:flex; align-items:center; gap:12px; padding:12px 16px;
            text-decoration:none; color:var(--text-muted); border-radius:8px;
            font-size:14px; font-weight:500; transition:all 0.2s; position:relative;
        }
        .nav-item i { font-size:20px; flex-shrink:0; }
        .nav-item:hover { color:var(--text-main); background:rgba(0,0,0,0.03); }
        .nav-item.active { background-color:var(--active-bg); color:var(--brand-brown); font-weight:600; }
        .nav-item.active::before {
            content:''; position:absolute; left:-16px; top:0; bottom:0;
            width:4px; background-color:var(--accent-orange); border-radius:0 4px 4px 0;
        }
        .sidebar-footer { padding:16px; border-top:1px solid var(--border-color); }

        /* Main */
        .main-content { flex:1; display:flex; flex-direction:column; overflow-y:auto; min-width:0; }

        /* Topbar */
        .topbar {
            display:flex; justify-content:space-between; align-items:center;
            padding:18px 40px; background-color:var(--card-bg);
            border-bottom:1px solid var(--border-color); flex-shrink:0;
            position:sticky; top:0; z-index:10;
        }
        .topbar h1 { font-size:22px; font-weight:700; }
        .topbar-right { display:flex; align-items:center; gap:16px; }
        .search-bar {
            display:flex; align-items:center; background-color:var(--bg-color);
            padding:9px 16px; border-radius:20px; gap:8px; width:260px;
            border:1px solid var(--border-color);
        }
        .search-bar i { color:var(--text-muted); font-size:16px; flex-shrink:0; }
        .search-bar input { border:none; background:none; outline:none; font-size:13px; width:100%; }
        .icon-btn {
            background:none; border:none; font-size:22px; color:var(--text-muted);
            cursor:pointer; display:flex; align-items:center; justify-content:center;
            width:36px; height:36px; border-radius:8px;
        }
        .icon-btn:hover { background-color:var(--bg-color); }
        .profile-pic {
            width:36px; height:36px; border-radius:50%;
            background:linear-gradient(135deg,#c8a882,#76533B);
            display:flex; align-items:center; justify-content:center;
            color:white; font-size:13px; font-weight:700; flex-shrink:0;
        }

        /* Content */
        .content-wrapper { padding:32px 40px; width:100%; }
        .page-header { display:flex; justify-content:space-between; align-items:flex-start; margin-bottom:28px; gap:24px; }
        .header-text h2 { font-size:18px; font-weight:700; margin-bottom:6px; }
        .header-text p  { color:var(--text-muted); font-size:14px; max-width:480px; line-height:1.5; }
        .header-actions { display:flex; gap:12px; align-items:center; flex-shrink:0; }
        .time-toggle {
            display:flex; background-color:var(--card-bg); border-radius:8px;
            padding:4px; border:1px solid var(--border-color); gap:2px;
        }
        .toggle-btn {
            border:none; background:none; padding:7px 14px; border-radius:6px;
            font-size:13px; font-weight:600; color:var(--text-muted); cursor:pointer;
        }
        .toggle-btn.active { background-color:var(--bg-color); color:var(--text-main); border:1px solid var(--border-color); }
        .export-btn {
            display:flex; align-items:center; gap:8px; background-color:var(--brand-brown);
            color:white; border:none; padding:9px 18px; border-radius:8px;
            font-size:13px; font-weight:600; cursor:pointer; white-space:nowrap;
        }

        /* Metrics */
        .metrics-grid { display:grid; grid-template-columns:repeat(4,1fr); gap:20px; margin-bottom:24px; }
        .metric-card {
            background-color:var(--card-bg); padding:22px 22px 22px 28px;
            border-radius:12px; position:relative;
            box-shadow:0 2px 12px rgba(0,0,0,0.04); overflow:hidden;
        }
        .card-indicator { position:absolute; left:0; top:20px; bottom:20px; width:4px; border-radius:0 4px 4px 0; }
        .card-indicator.brown       { background-color:var(--brand-brown); }
        .card-indicator.light-brown { background-color:#D3BDB0; }
        .metric-title  { font-size:13px; color:var(--text-muted); font-weight:500; margin-bottom:10px; }
        .metric-value  { font-size:26px; font-weight:700; margin-bottom:10px; line-height:1.2; }
        .metric-change { font-size:12px; display:flex; align-items:center; gap:5px; font-weight:600; }
        .metric-change.positive { color:var(--accent-green); }
        .metric-change.neutral  { color:var(--accent-orange); }

        /* Charts */
        .charts-section { display:grid; grid-template-columns:2fr 1fr; gap:20px; margin-bottom:24px; }
        .card { background-color:var(--card-bg); padding:28px; border-radius:12px; box-shadow:0 2px 12px rgba(0,0,0,0.04); }
        .chart-header { display:flex; justify-content:space-between; align-items:flex-start; margin-bottom:24px; }
        .chart-header h3 { font-size:18px; font-weight:700; margin-bottom:4px; }
        .chart-header p  { color:var(--text-muted); font-size:14px; }
        .chart-legend { display:flex; gap:16px; font-size:11px; font-weight:700; color:var(--text-muted); letter-spacing:0.5px; align-items:center; }
        .legend-item { display:flex; align-items:center; gap:6px; }
        .dot { width:10px; height:10px; border-radius:50%; }
        .dot.online  { background-color:var(--brand-brown); }
        .dot.instore { background-color:#AFA096; }
        .chart-area { position:relative; width:100%; }
        .bar-chart-svg { width:100%; height:200px; }
        .x-axis-labels {
            display:flex; justify-content:space-around; padding-top:10px;
            color:var(--text-muted); font-size:11px; font-weight:600;
            border-top:1px solid var(--border-color);
        }

        /* Flavors */
        .popular-flavors h3 { font-size:18px; font-weight:700; margin-bottom:4px; }
        .popular-flavors > p { color:var(--text-muted); font-size:14px; margin-bottom:24px; }
        .flavors-list { display:flex; flex-direction:column; gap:20px; }
        .flavor-item  { display:flex; align-items:center; gap:16px; }
        .rank { width:40px; height:40px; border-radius:50%; display:flex; align-items:center; justify-content:center; font-weight:700; font-size:14px; flex-shrink:0; }
        .rank-1 { background-color:#F8DEBA; color:#8C5930; }
        .rank-2 { background-color:#FAE0E0; color:#C56F6F; }
        .rank-3 { background-color:#F1F1F1; color:#7B7B7B; }
        .rank-4 { background-color:#F7F7F7; color:#AEAEAE; }
        .flavor-info { flex:1; min-width:0; }
        .flavor-name-val { display:flex; justify-content:space-between; margin-bottom:8px; font-size:13px; font-weight:600; gap:8px; }
        .flavor-name-val .name { white-space:nowrap; overflow:hidden; text-overflow:ellipsis; }
        .flavor-name-val .val  { color:var(--text-muted); flex-shrink:0; }
        .progress-bar { height:6px; background-color:var(--bg-color); border-radius:4px; overflow:hidden; }
        .progress-bar .fill { height:100%; border-radius:4px; }
        .fill-1 { width:85%; background-color:var(--brand-brown); }
        .fill-2 { width:65%; background-color:#C4AFA8; }
        .fill-3 { width:45%; background-color:#C4AFA8; }
        .fill-4 { width:30%; background-color:#C4AFA8; }
        .text-btn { background:none; border:none; color:var(--brand-brown); font-weight:600; font-size:13px; margin-top:28px; cursor:pointer; text-align:center; width:100%; display:block; }

        /* Bottom */
        .bottom-section { display:grid; grid-template-columns:1fr 1fr; gap:20px; }
        .customer-velocity { position:relative; overflow:hidden; }
        .customer-velocity::after {
            content:''; position:absolute; bottom:-60px; right:-40px;
            width:200px; height:200px; background-color:#F8F6F4; border-radius:50%; z-index:0;
        }
        .velocity-content { position:relative; z-index:1; }
        .customer-velocity h3 { font-size:18px; font-weight:700; margin-bottom:4px; }
        .customer-velocity > .velocity-content > p { color:var(--text-muted); font-size:14px; }
        .velocity-stats { display:flex; align-items:center; margin:28px 0; }
        .stat h2 { font-size:32px; font-weight:700; margin-bottom:6px; }
        .stat p  { font-size:11px; font-weight:600; letter-spacing:0.5px; }
        .stat.divider { width:1px; height:56px; background-color:var(--border-color); margin:0 40px; flex-shrink:0; }
        .loyalty-info { border-top:1px solid var(--border-color); padding-top:24px; }
        .loyalty-info p { font-size:13px; font-style:italic; color:var(--text-muted); line-height:1.5; margin-bottom:20px; }
        .avatar-group { display:flex; align-items:center; }
        .avatar-circle { width:36px; height:36px; border-radius:50%; border:2px solid white; margin-right:-10px; display:flex; align-items:center; justify-content:center; font-weight:700; font-size:12px; color:white; flex-shrink:0; }
        .avatar-1 { background:linear-gradient(135deg,#e8b87a,#c47640); }
        .avatar-2 { background:linear-gradient(135deg,#7fbbde,#4a89ab); }
        .avatar-3 { background:linear-gradient(135deg,#a8d8a8,#5aaa5a); }
        .avatar-more { width:36px; height:36px; border-radius:50%; background-color:#E2CFB4; color:var(--brand-brown); font-size:11px; font-weight:700; display:flex; align-items:center; justify-content:center; border:2px solid white; z-index:1; flex-shrink:0; }

        /* Small Cards */
        .small-cards { display:grid; grid-template-columns:1fr 1fr; gap:20px; }
        .small-card { padding:24px; border-radius:12px; }
        .small-card.peak-hours      { background-color:#FCEBE1; }
        .small-card.top-region      { background-color:#F5EFEB; }
        .small-card.brew-efficiency { grid-column:1 / -1; background-color:#F7DBC1; }
        .icon-brown { font-size:28px; color:var(--brand-brown); margin-bottom:14px; display:block; }
        .small-card .title { color:var(--brand-brown); font-size:12px; font-weight:700; margin-bottom:10px; }
        .small-card h3    { font-size:22px; font-weight:700; margin-bottom:6px; }
        .small-card .desc { font-size:12px; color:var(--text-main); line-height:1.4; }
        .brew-efficiency  { display:flex; align-items:center; gap:20px; }
        .icon-wrap { width:48px; height:48px; background-color:white; border-radius:10px; display:flex; align-items:center; justify-content:center; font-size:24px; color:var(--brand-brown); flex-shrink:0; }
        .brew-info { flex:1; display:flex; justify-content:space-between; align-items:center; }
        .right-stat { text-align:right; }
        .right-stat h3   { color:var(--accent-green); margin-bottom:4px; font-size:22px; }
        .right-stat .desc { font-size:10px; font-weight:700; letter-spacing:0.5px; color:var(--text-muted); }
    </style>
</head>
<body>
<div class="dashboard">

    <aside class="sidebar">
        <div class="sidebar-header">
            <h2>MithoCha Admin</h2>
            <p>Premium Bubble Tea</p>
        </div>
        <nav class="sidebar-nav">
            <a href="${pageContext.request.contextPath}/admin/dashboard" class="nav-item active">
                <i class="ph ph-squares-four"></i> Dashboard
            </a>
            <a href="${pageContext.request.contextPath}/admin/menu" class="nav-item">
                <i class="ph ph-coffee"></i> Menu Management
            </a>
            <a href="${pageContext.request.contextPath}/admin/orders" class="nav-item">
                <i class="ph ph-shopping-bag"></i> Orders Management
            </a>
            <a href="${pageContext.request.contextPath}/admin/customers" class="nav-item">
                <i class="ph ph-users"></i> Customers Management
            </a>
            <a href="${pageContext.request.contextPath}/admin/inventory" class="nav-item">
                <i class="ph ph-package"></i> Inventory
            </a>
            <a href="${pageContext.request.contextPath}/admin/offers" class="nav-item">
                <i class="ph ph-tag"></i> Offers &amp; Discounts
            </a>
            <a href="${pageContext.request.contextPath}/admin/analytics" class="nav-item ">
                <i class="ph ph-chart-bar"></i> Analytics
            </a>
            <a href="${pageContext.request.contextPath}/admin/billing" class="nav-item">
                <i class="ph ph-receipt"></i> Invoices
            </a>
        </nav>
        <div class="sidebar-footer">
            <a href="#" class="nav-item"><i class="ph ph-sign-out"></i> Logout</a>
        </div>
    </aside>

    <main class="main-content">
        <header class="topbar">
            <h1>MithoCha</h1>
            <div class="topbar-right">
                <div class="search-bar">
                    <i class="ph ph-magnifying-glass"></i>
                    <input type="text" placeholder="Search data...">
                </div>
                <button class="icon-btn"><i class="ph ph-bell"></i></button>
                <button class="icon-btn"><i class="ph ph-gear"></i></button>
                <div class="profile-pic">A</div>
            </div>
        </header>

        <div class="content-wrapper">
            <div class="page-header">
                <div class="header-text">
                    <h2>Business Intelligence</h2>
                    <p>Visualizing your premium bubble tea performance. Track sales velocity, customer acquisition, and flavor trends.</p>
                </div>
                <div class="header-actions">
                    <div class="time-toggle">
                        <button class="toggle-btn active">Daily</button>
                        <button class="toggle-btn">Weekly</button>
                        <button class="toggle-btn">Monthly</button>
                    </div>
                    <button class="export-btn"><i class="ph ph-download-simple"></i> Export Report</button>
                </div>
            </div>

            <div class="metrics-grid">
                <div class="metric-card">
                    <div class="card-indicator brown"></div>
                    <p class="metric-title">Total Sales</p>
                    <h3 class="metric-value">Rs. 4,28,500</h3>
                    <p class="metric-change positive"><i class="ph ph-trend-up"></i> 12.5% vs last month</p>
                </div>
                <div class="metric-card">
                    <div class="card-indicator light-brown"></div>
                    <p class="metric-title">Average Order Value</p>
                    <h3 class="metric-value">Rs. 540</h3>
                    <p class="metric-change positive"><i class="ph ph-trend-up"></i> 4.2% from peak</p>
                </div>
                <div class="metric-card">
                    <div class="card-indicator brown"></div>
                    <p class="metric-title">New Customers</p>
                    <h3 class="metric-value">1,204</h3>
                    <p class="metric-change positive"><i class="ph ph-user-plus"></i> 18% month over month</p>
                </div>
                <div class="metric-card">
                    <div class="card-indicator brown"></div>
                    <p class="metric-title">Satisfaction Score</p>
                    <h3 class="metric-value">4.8/5.0</h3>
                    <p class="metric-change neutral"><i class="ph ph-star"></i> Top 5% in category</p>
                </div>
            </div>

            <div class="charts-section">
                <div class="revenue-chart card">
                    <div class="chart-header">
                        <div>
                            <h3>Revenue Trends</h3>
                            <p>Daily performance across all outlets</p>
                        </div>
                        <div class="chart-legend">
                            <span class="legend-item"><span class="dot online"></span> ONLINE</span>
                            <span class="legend-item"><span class="dot instore"></span> IN-STORE</span>
                        </div>
                    </div>
                    <div class="chart-area">
                        <svg class="bar-chart-svg" viewBox="0 0 560 200" preserveAspectRatio="none" xmlns="http://www.w3.org/2000/svg">
                            <line x1="0" y1="0"   x2="560" y2="0"   stroke="#F1EAE4" stroke-width="1"/>
                            <line x1="0" y1="50"  x2="560" y2="50"  stroke="#F1EAE4" stroke-width="1"/>
                            <line x1="0" y1="100" x2="560" y2="100" stroke="#F1EAE4" stroke-width="1"/>
                            <line x1="0" y1="150" x2="560" y2="150" stroke="#F1EAE4" stroke-width="1"/>
                            <line x1="0" y1="199" x2="560" y2="199" stroke="#F1EAE4" stroke-width="1"/>
                            <rect x="20"  y="110" width="26" height="90"  rx="4" fill="#76533B"/><rect x="50"  y="140" width="26" height="60"  rx="4" fill="#AFA096"/>
                            <rect x="100" y="90"  width="26" height="110" rx="4" fill="#76533B"/><rect x="130" y="130" width="26" height="70"  rx="4" fill="#AFA096"/>
                            <rect x="180" y="70"  width="26" height="130" rx="4" fill="#76533B"/><rect x="210" y="120" width="26" height="80"  rx="4" fill="#AFA096"/>
                            <rect x="260" y="100" width="26" height="100" rx="4" fill="#76533B"/><rect x="290" y="145" width="26" height="55"  rx="4" fill="#AFA096"/>
                            <rect x="340" y="60"  width="26" height="140" rx="4" fill="#76533B"/><rect x="370" y="110" width="26" height="90"  rx="4" fill="#AFA096"/>
                            <rect x="420" y="30"  width="26" height="170" rx="4" fill="#76533B"/><rect x="450" y="80"  width="26" height="120" rx="4" fill="#AFA096"/>
                            <rect x="500" y="50"  width="26" height="150" rx="4" fill="#76533B"/><rect x="530" y="100" width="26" height="100" rx="4" fill="#AFA096"/>
                        </svg>
                        <div class="x-axis-labels">
                            <span>MON</span><span>TUE</span><span>WED</span>
                            <span>THU</span><span>FRI</span><span>SAT</span><span>SUN</span>
                        </div>
                    </div>
                </div>

                <div class="popular-flavors card">
                    <h3>Most Popular</h3>
                    <p>Top flavor profiles this week</p>
                    <div class="flavors-list">
                        <div class="flavor-item">
                            <div class="rank rank-1">#1</div>
                            <div class="flavor-info">
                                <div class="flavor-name-val"><span class="name">Royal Assam Milk Tea</span><span class="val">32%</span></div>
                                <div class="progress-bar"><div class="fill fill-1"></div></div>
                            </div>
                        </div>
                        <div class="flavor-item">
                            <div class="rank rank-2">#2</div>
                            <div class="flavor-info">
                                <div class="flavor-name-val"><span class="name">Honeydew Melon Burst</span><span class="val">24%</span></div>
                                <div class="progress-bar"><div class="fill fill-2"></div></div>
                            </div>
                        </div>
                        <div class="flavor-item">
                            <div class="rank rank-3">#3</div>
                            <div class="flavor-info">
                                <div class="flavor-name-val"><span class="name">Classic Taro Slush</span><span class="val">18%</span></div>
                                <div class="progress-bar"><div class="fill fill-3"></div></div>
                            </div>
                        </div>
                        <div class="flavor-item">
                            <div class="rank rank-4">#4</div>
                            <div class="flavor-info">
                                <div class="flavor-name-val"><span class="name">Brown Sugar Boba</span><span class="val">12%</span></div>
                                <div class="progress-bar"><div class="fill fill-4"></div></div>
                            </div>
                        </div>
                    </div>
                    <button class="text-btn">View full flavor audit &rarr;</button>
                </div>
            </div>

            <div class="bottom-section">
                <div class="customer-velocity card">
                    <div class="velocity-content">
                        <h3>Customer Velocity</h3>
                        <p>Retention and acquisition rate</p>
                        <div class="velocity-stats">
                            <div class="stat"><h2>82%</h2><p>RETENTION RATE</p></div>
                            <div class="stat divider"></div>
                            <div class="stat"><h2>+412</h2><p>NEW THIS WEEK</p></div>
                        </div>
                        <div class="loyalty-info">
                            <p>"The Loyalty program launched in Feb has increased repeat visits by 22%."</p>
                            <div class="avatar-group">
                                <div class="avatar-circle avatar-1">A</div>
                                <div class="avatar-circle avatar-2">B</div>
                                <div class="avatar-circle avatar-3">C</div>
                                <div class="avatar-more">+1k</div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="small-cards">
                    <div class="small-card peak-hours">
                        <i class="ph-fill ph-clock icon-brown"></i>
                        <p class="title">Peak Hours</p>
                        <h3>4 PM - 7 PM</h3>
                        <p class="desc">65% of daily revenue generated</p>
                    </div>
                    <div class="small-card top-region">
                        <i class="ph-fill ph-map-trifold icon-brown"></i>
                        <p class="title">Top Region</p>
                        <h3>Durbar Marg</h3>
                        <p class="desc">Outperforming other stores by 14%</p>
                    </div>
                    <div class="small-card brew-efficiency">
                        <div class="icon-wrap"><i class="ph ph-coffee"></i></div>
                        <div class="brew-info">
                            <div>
                                <p class="title">Brew Efficiency</p>
                                <p class="desc">Avg. preparation time: 3.2 min</p>
                            </div>
                            <div class="right-stat">
                                <h3>-18s</h3>
                                <p class="desc">VS LAST MONTH</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </main>
</div>
</body>
</html>
