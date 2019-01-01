- How will we recognize each other's successes and celebrate them?
    - lets go out to lunch
    - celebrate on slack
    # Little Shop of Orders, v2
    BE Mod 2 Week 4/5 Group Project
    ## Background and Description
    "Little Shop of Orders" is a fictitious e-commerce platform where users can register to place items into a shopping cart and 'check out'. Merchant users can mark items as 'fulfilled', and Admins can mark orders as 'complete'. Each user role will have access to some or all CRUD functionality for application models.

    Students will be put into 3 or 4 person groups to complete the project.

    ## Learning Goals
    - Advanced Rails routing (nested resources and namespacing)
    - Advanced ActiveRecord for calculating statistics
    - Average HTML/CSS layout and design for UX/UI
    - Session management and use of POROs for shopping cart
    - Authentication, Authorization, separation of user roles and permissions

    ## Requirements
    - must use Rails 5.1.x
    - must use PostgreSQL
    - must use 'bcrypt' for authentication
    - all controller and model code must be tested via feature tests and model tests, respectively
    - must use good GitHub branching, team code reviews via GitHub comments, and use of a project planning tool like waffle.io
    - must include a thorough README to describe their project

    ## Permitted
    - use FactoryBot to speed up your test development
    - use "rails generators" to speed up your app development

    ## Not Permitted
    - do not use JavaScript for pagination or sorting controls

    ## Permission
    - if there is a specific gem you'd like to use in the project, please get permission from your instructors first

    ## User Roles
    1. Visitor - this type of user is anonymously browsing our site and is not logged in
    2. Registered User - this user is registered and logged in to the application while performing their work; can place items in a cart and create an order
    3. Merchant User - a registered user who is also has access to merchant data and operations; user is logged in to perform their work
    4. Admin User - a registered user (but cannot also be a merchant) who has "superuser" access to all areas of the application; user is logged in to perform their work

    ## Order Status
    1. 'pending' means a user has placed items in a cart and "checked out", but no merchant had fulfilled any items yet
    2. 'processing' means one or more merchants have fulfilled items from the order
    3. 'complete' means all merchants have fulfilled their items for the order
    4. 'cancelled' only 'pending' and 'processing' orders can be cancelled

    ## Not Everything can be FULLY Deleted
    In the user stories, we talk about "CRUD" functionality. However, it's rare in a real production system to ever truly delete content, and instead we typically just 'enable' or 'disable' content. Users, items and orders can be 'enabled' or 'disabled' which blocks functionality (users whose accounts are disabled should not be allowed to log in, items which are disabled cannot be ordered, orders which are disabled cannot be processed, and so on).

    Disabled content should also be restricted from showing up in the statistics pages. For example if a user is disabled they should not appear in a list of "users with most orders"; if an order is disabled it should not be considered as part of "top sales" and so on.

    Be careful to watch out for which stories allow full deletion of content, and restrictions on when they apply.

    ## User Stories

    Your team may not be able to work on these stories in numeric order. Work together to determine the best starting place and work from there.

    - [Little Shop v2 stories](https://github.com/turingschool-projects/little_shop_v2/blob/master/stories.md)


    ## Rubric, Evaluations, and final Assessment

    Each team will meet with an instructor at least two times before the project is due.

    - At first team progress check-in, about 33% of the work is expected to be completed satisfactorily
    - At second team progress check-in, about 66% of the work is expected to be completed satisfactorily
    - Final submission will expect 100% completion

    Each team will have a rubric uploaded to [https://github.com/turingschool/ruby-submissions](https://github.com/turingschool/ruby-submissions)


    View the [Little Shop Rubric](LittleShopRubric.pdf)
