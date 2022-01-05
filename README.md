<h1>Creating a Rails API from Scratch<h1>
 <h2>Learning Goals</h2>  <ul> <li>Use the <code>--api</code> flag to create an API-only Rails app</li> <li>Use the <code>resource</code> generator</li> </ul>  <h2>Introduction</h2>  <p>We've spent a lot of time now focusing on the backend, and now's a great opportunity to see what we can actually do with all the power of a Rails API to support a frontend application as well.</p>  <p>Throughout this section, we'll be building a DVD shop. We'll have a Rails API to support a React frontend application, and we'll be focusing on how that client-server communication process works, as well as some challenges involved in communicating between two separate applications.</p>  <p>In this lesson, we'll start by building the Rails backend from scratch and talk through some of the typical configuration when creating a new Rails API.</p>  <h2>Generating a Rails API</h2>  <p>Just like we saw at the beginning of the phase, we can use <code>rails new</code> to generate a new Rails application. We'll run that same command with a few additional options to optimize our Rails app. Let's generate the backend code for our <code>dvd-shop</code>. Use <code>cd ..</code> to navigate out of the lab directory, and run:</p> <pre><code>rails new dvd-shop --api --minimal </code></pre> <ul> <li>
<code>--api</code>: this flag will create our new application with some additional API-specific configuration, and will skip the code for generating <code>.erb</code> files with ActionView.</li> <li>
<code>--minimal</code>: this flag skips a lot of additional Rails features that we won't use in our API, such as code for sending emails and processing images. Read more about the <a href="https://bigbinary.com/blog/rails-6-1-adds-minimal-option-support" target="_blank"><code>--minimal</code> flag</a><span><span data-reactroot="" class="external-link-indicator external-link-indicator__wrapper"><span><svg version="=&quot;1.1&quot;" xmlns="=&quot;http://www.w3.org/2000/svg&quot;" tabindex="0" name="IconExportLine" viewBox="0 0 1920 1920" width="1em" height="0.8rem" aria-hidden="true" role="presentation" focusable="false" style="fill: currentcolor; width: 1em; height: 0.8rem;"><g role="presentation">
    <g stroke="none" strokewidth="1" fillrule="evenodd">
        <path d="M1360 446.872l-113.12 113.12 160 160H960c-176.48 0-320 143.52-320 320v80h160v-80c0-88.16 71.76-160 160-160h446.88l-160 160 113.12 113.12 353.12-353.12L1360 446.872z"></path>
        <path d="M1040 1440H320V480h880V320H160v1280h1040v-400h-160z"></path>
    </g>
</g></svg><!-- react-empty: 5 --></span><span class="_1GLewti">This is an external link.</span></span></span>.</li> </ul>  <blockquote> <p>The reason we ask you to <code>cd</code> out of the lab directory is because when you generate a new Rails project, it will automatically create a new Git repository for your Rails project. Since the lab directory is already a Git repository, it's better to create this new project in its own directory, so you don't end up with nested Git repositories.</p> </blockquote>  <p>With that code in place, let's generate the code for handling our first request from the client.</p>  <h2>Using the Resource Generator</h2>  <p>One of the main features of our frontend application will be to display a list of movies. For that feature, we'll want our API to handle a <code>GET</code> request to <code>/movies</code>.</p>  <p>To get that request working, we'll need to create a <strong>route</strong> and <strong>controller</strong> action on our Rails server. We'll also need a <strong>model</strong> to interact with the database, and a <strong>migration</strong> to generate the corresponding database table for this model.</p>  <p>For our <code>Movie</code> model, we'll want a table with the following attributes:</p>  <table border="1" cellpadding="4" cellspacing="0">   <tbody>
<tr>     <th>Column Name</th>     <th>Data Type</th>   </tr>   <tr>     <td>title</td>     <td>string</td>   </tr>   <tr>     <td>year</td>     <td>integer</td>   </tr>   <tr>     <td>length</td>     <td>integer</td>   </tr>   <tr>     <td>description</td>     <td>string</td>   </tr>   <tr>     <td>poster_url</td>     <td>string</td>   </tr>   <tr>     <td>category</td>     <td>string</td>   </tr>   <tr>     <td>discount</td>     <td>boolean</td>   </tr>   <tr>     <td>female_director</td>     <td>boolean</td>   </tr> </tbody>
</table>  <p>We could create the route, model, controller, and migration individually, but since this kind of operation is pretty common for a Rails developer, there's a handy generator that will set up all the code we need: <code>rails g resource</code>.</p>  <p>Navigate into the <code>dvd-shop</code> directory and run this code in your terminal:</p> <pre><code>rails g resource Movie title year:integer length:integer director description poster_url category discount:boolean female_director:boolean --no-test-framework </code></pre> <p>This command will:</p>  <ul> <li>Generate a migration for creating a <code>movies</code> table with the specified attributes</li> <li>Generate a <code>Movie</code> model file</li> <li>Generate a <code>MoviesController</code> controller file</li> <li>Add <code>resources :movies</code> to the <code>routes.rb</code> file</li> </ul>  <p>It's a powerful command, so make sure to use it sparingly! You should only use <code>rails g resource</code> if you truly need all of that code generated.</p>  <h2>Running the API</h2>  <p>To get some sample data into our application, we've provided a <code>seeds.rb</code> file in the root directory of this repo. Copy the contents of this file into your <code>db/seeds.rb</code> file. Then, to set up and seed the database, run:</p> <pre><code>rails db:migrate db:seed </code></pre> <p>Let's update our <code>routes.rb</code> file to set up just the one route our frontend needs, for the time being:</p> <pre><code># config/routes.rb<br>resources :movies, only: [:index] </code></pre> <p>We can also add the index action to our controller:</p> <pre><code>def index<br>  movies = Movie.all<br>  render json: movies<br>end </code></pre> <p>With that code in place, run <code>rails s</code> to start the server, and visit <code>http://localhost:3000/movies</code> in the browser to see our movie data. Success!</p>  <h2>Conclusion</h2>  <p>When creating a new Rails API project from scratch, you can use the <code>--api</code> flag to have Rails optimize your project for building a web API.</p>  <p>We also saw how to use the <code>resource</code> generator, which can help quickly set up the code we need to create RESTful routes and CRUD functionality for one single resource.</p>  <h2>Resources</h2>  <ul> <li><a href="https://guides.rubyonrails.org/command_line.html" target="_blank">The Rails Command Line</a><span><span data-reactroot="" class="external-link-indicator external-link-indicator__wrapper"><span><svg version="=&quot;1.1&quot;" xmlns="=&quot;http://www.w3.org/2000/svg&quot;" tabindex="0" name="IconExportLine" viewBox="0 0 1920 1920" width="1em" height="0.8rem" aria-hidden="true" role="presentation" focusable="false" style="fill: currentcolor; width: 1em; height: 0.8rem;"><g role="presentation">
    <g stroke="none" strokewidth="1" fillrule="evenodd">
        <path d="M1360 446.872l-113.12 113.12 160 160H960c-176.48 0-320 143.52-320 320v80h160v-80c0-88.16 71.76-160 160-160h446.88l-160 160 113.12 113.12 353.12-353.12L1360 446.872z"></path>
        <path d="M1040 1440H320V480h880V320H160v1280h1040v-400h-160z"></path>
    </g>
</g></svg><!-- react-empty: 5 --></span><span class="_1GLewti">This is an external link.</span></span></span></li> </ul></span></div><div class="content__footer"><a href="content/g390b057f64131e231d606c68fc936bd9" type="button" class="_1OIPJSt _3VBMzNv _3fSHh4K" style="margin: 0px;"><svg version="=&quot;1.1&quot;" xmlns="=&quot;http://www.w3.org/2000/svg&quot;" name="IconArrowOpenLeftSolid" viewBox="0 0 1920 1920" width="1em" height="1em" aria-hidden="true" role="presentation" focusable="false" style="fill: currentcolor; width: 1em; height: 1em;"><g role="presentation">
    <path d="M863.702 960l520.212-519.957c64.477-64.444 64.474-168.117.498-232.062-64.423-64.39-167.926-63.722-232.177.497L535.42 824.991c-37.06 37.041-52.817 87.042-47.37 135.009-5.447 47.967 10.31 97.968 47.37 135.009l616.816 616.513c64.251 64.22 167.754 64.887 232.177.497 63.976-63.945 63.979-167.618-.498-232.062L863.702 960z" stroke="none" strokewidth="1" fillrule="evenodd"></path>
